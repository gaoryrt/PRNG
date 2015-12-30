//
//  OutputViewController.swift
//  PRNG
//
//  Created by gaoryrt on 15/11/8.
//  Copyright © 2015年 gaoryrt. All rights reserved.
//

import UIKit
import CryptoSwift

class OutputViewController: UIViewController,UIAccelerometerDelegate {
    
    var formatter:NSDateFormatter = NSDateFormatter()
    
    var choosenALG = ""
    var choosenK = ""
    var choosenFuncH = ""
    var choosenFuncEx = ""
    var choosenFuncEDE = ""
    var choosenIterTime = ""
    var choosenExpanTime = ""
    var spendedtime1 = ""
    var spendedtime2 = ""
    var hextext = ""
    var bitext = ""
    var ispresenthex = true
    var 输出长度 = 2048
    
    @IBOutlet weak var outputTextView: UITextView!
    

        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        formatter.dateFormat = "yyyyMMddHHmmssSSSS"
        spendedtime1 = gettimestring()
        switch choosenALG{
            case "Hash链": hashlian()
            case "ANSI X9.17": ansi()
            case "随机化迭代": rig()
            case "扩展随机化迭代": erig()
            default: break
        }
        spendedtime2 = gettimestring()
//        print(choosenK)
        let stringg = String((Int64(spendedtime2)!-Int64(spendedtime1)!)/10)+" ms"
        let alertController = UIAlertController(title: "花费时间", message:
            stringg, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,
            handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
        // Do any additional setup after loading the view.
        hextobi()
        outputTextView.text = hextext
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func hashlian() {
        var key = choosenK
        var output = ""
        var hash = ""
        //循环 hash
        for _ in 1...Int(choosenIterTime)! {
            switch choosenFuncH {
            case "SHA-1": hash = key.sha1()
            case "MD5": hash = key.md5()
            case "SHA-224":  hash = key.sha224()
            case "SHA-256":  hash = key.sha256()
            case "SHA-384":  hash = key.sha384()
            case "SHA-512":  hash = key.sha512()
            default : break
            }
            output += hash
            key = hash
        }
        //字符串截取
        if output.characters.count >= 输出长度{
        output = (output as NSString).substringToIndex(输出长度)
        }
        hextext = output
    }
    
    func ansi() {
        let key = choosenK
        var hash = ""
        var output = ""
        var output3 = ("" as NSString).dataUsingEncoding(NSUTF8StringEncoding)!
        for i in 1...Int(choosenIterTime)! {
        var last = ("" as NSString).dataUsingEncoding(NSUTF8StringEncoding)!
        //hash 算法的选择
            switch choosenFuncH {
            case "SHA-1": hash = key.sha1()
            case "MD5": hash = key.md5()
            case "SHA-224":  hash = key.sha224()
            case "SHA-256":  hash = key.sha256()
            case "SHA-384":  hash = key.sha384()
            case "SHA-512":  hash = key.sha512()
            default : break
            }
            //ansi 两个key 的获得
            let keyString = gettimestring()
            let keyData = (keyString as NSString).dataUsingEncoding(NSUTF8StringEncoding)
            let ivString = hash
            let ivData = (ivString as NSString).dataUsingEncoding(NSUTF8StringEncoding)
            let timeData = (gettimestring()as NSString).dataUsingEncoding(NSUTF8StringEncoding)
            let output1 = EDE(keyData!, ivdata: ivData!, DT: timeData!)
            var DT2 = output1
            if i != 1{
                 DT2 = xor(last, data2: output1)
            }
            let output2 = EDE(keyData!, ivdata: ivData!, DT: DT2)
            let DT3 = xor(output1, data2: output2)
            output3 = EDE(keyData!, ivdata: ivData!, DT: DT3)
            let outputuint = output3.arrayOfBytes()
            var outputstring = ""
            for i in outputuint {
                outputstring += String(format:"%2X", i)
            }
            outputstring = outputstring.stringByReplacingOccurrencesOfString(" ", withString: "0", options: NSStringCompareOptions.LiteralSearch, range: nil)
            last = (outputstring as NSString).dataUsingEncoding(NSUTF8StringEncoding)!
            output += outputstring
        }
        if output.characters.count >= 输出长度{
            output = (output as NSString).substringToIndex(输出长度)
        }
        hextext = output
    }
    
    func testCrypt3DES(data data:NSData, keyData:NSData, ivData:NSData, operation:CCOperation) -> NSData? {
        let keyBytes = UnsafePointer<UInt8>(keyData.bytes)
        let ivBytes = UnsafePointer<UInt8>(ivData.bytes)
        let dataLength = Int(data.length)
        let dataBytes  = UnsafePointer<UInt8>(data.bytes)
        let cryptData: NSMutableData! = NSMutableData(length: Int(dataLength) + kCCBlockSize3DES)
        let cryptPointer = UnsafeMutablePointer<UInt8>(cryptData.mutableBytes)
        let cryptLength  = size_t(cryptData.length)
        
        let keyLength              = size_t(kCCKeySize3DES)
        let algoritm:  CCAlgorithm = UInt32(kCCAlgorithm3DES)
        let options:   CCOptions   = UInt32(kCCOptionPKCS7Padding)
        
        var numBytesEncrypted :size_t = 0
        
        let cryptStatus = CCCrypt(operation,
            algoritm,
            options,
            keyBytes, keyLength,
            ivBytes,
            dataBytes, dataLength,
            cryptPointer, cryptLength,
            &numBytesEncrypted)
        
        if UInt32(cryptStatus) == UInt32(kCCSuccess) {
            cryptData.length = Int(numBytesEncrypted)
            
        } else {
            print("Error: \(cryptStatus)")
        }
        
        return cryptData;
    }

    func gettimestring() -> String {
        let date = NSDate()
        let dateString = formatter.stringFromDate(date)
        return dateString
    }
    
    func EDE(keydata:NSData,ivdata:NSData,DT:NSData)->NSData{
//        let keystring = NSString(data: keydata, encoding: NSUTF8StringEncoding) as! String
//        let ivstring = NSString(data: ivdata, encoding: NSUTF8StringEncoding) as! String
        var output = ("" as NSString).dataUsingEncoding(NSUTF8StringEncoding)!
        switch choosenFuncEDE {
        case "EDE": output = testCrypt3DES(data:DT, keyData:keydata, ivData:ivdata, operation:UInt32(kCCEncrypt))!
//        case "AES": output = aes(keydata, ivdata: ivdata, DT: DT)    
        default: break
        }
        return output
    }
    
    func xor(data1:NSData,data2:NSData) -> NSData{
        var output = ("" as NSString).dataUsingEncoding(NSUTF8StringEncoding)!
        var theData:[UInt8] = []
        var thenumber = data1.arrayOfBytes().count
        if data1.arrayOfBytes().count > data2.arrayOfBytes().count {
            thenumber = data2.arrayOfBytes().count
        }
        for i in 0..<thenumber{
            let temp = (data1.arrayOfBytes())[i] ^ (data2.arrayOfBytes())[i]
            theData.append(temp)
            
        }
        output = NSData(bytes: &theData, length: theData.count)
        return output
    }
    
    func rig() {
        var key = choosenK
        var output = ""
        var aftf = ""
        var afth = ""
        for _ in 1...Int(choosenIterTime)! {
            switch choosenFuncEx {
            case "SHA-1": aftf = key.sha1()
            case "MD5": aftf = key.md5()
            case "SHA-224":  aftf = key.sha224()
            case "SHA-256":  aftf = key.sha256()
            case "SHA-384":  aftf = key.sha384()
            case "SHA-512":  aftf = key.sha512()
            default : break
            }
            output += aftf
            switch choosenFuncH {
            case "SHA-1": afth = aftf.sha1()
            case "MD5": afth = aftf.md5()
            case "SHA-224":  afth = aftf.sha224()
            case "SHA-256":  afth = aftf.sha256()
            case "SHA-384":  afth = aftf.sha384()
            case "SHA-512":  afth = aftf.sha512()
            default : break
            }
            key = afth
        }
        if output.characters.count >= 输出长度{
            output = (output as NSString).substringToIndex(输出长度)
        }
            hextext = output
    }
    
    func erig() {
        var key = choosenK
        var output = ""
        var aftf = ""
        var afth = ""
        var bfh = ""
        var bff = ""
        for _ in 1...Int(choosenIterTime)! {
            for _ in 1...Int(choosenExpanTime)! {
                switch choosenFuncEx {
                case "SHA-1": aftf = key.sha1()
                case "MD5": aftf = key.md5()
                case "SHA-224":  aftf = key.sha224()
                case "SHA-256":  aftf = key.sha256()
                case "SHA-384":  aftf = key.sha384()
                case "SHA-512":  aftf = key.sha512()
                default : break
                }
                key = aftf
                bfh += aftf
            }
            output += bfh
            for _ in 1...Int(choosenExpanTime)! {
                switch choosenFuncH {
                case "SHA-1": afth = bfh.sha1()
                case "MD5": afth = bfh.md5()
                case "SHA-224":  afth = bfh.sha224()
                case "SHA-256":  afth = bfh.sha256()
                case "SHA-384":  afth = bfh.sha384()
                case "SHA-512":  afth = bfh.sha512()
                default : break
                }
                bfh = afth
                bff += afth
            }
            key = bff
        }
        if output.characters.count >= 输出长度{
            output = (output as NSString).substringToIndex(输出长度)
        }
        hextext = output
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func addspace(input:String) -> String {
//        print(input)
        var output = ""
        var count = 0
        for i in input.characters {

        output.append(i)
            if count%2==1 {
                output += " "
            }
            count += 1
        }
//        print(output)
        return output
        
    }
    
    @IBAction func changeInter(sender: AnyObject) {
            if ispresenthex {
            outputTextView.text = bitext
            ispresenthex = false
            }
            else {
            outputTextView.text = hextext
            ispresenthex = true
            }
    }
    
    func hextobi() {
        var output = ""
        for i in hextext.characters{
        switch i {
    case "A": output += "1010"
    case "B": output += "1011"
    case "C": output += "1100"
    case "D": output += "1101"
    case "E": output += "1110"
    case "F": output += "1111"
    case "0": output += "0000"
    case "1": output += "0001"
    case "2": output += "0010"
    case "3": output += "0011"
    case "4": output += "0100"
    case "5": output += "0101"
    case "6": output += "0110"
    case "7": output += "0111"
    case "8": output += "1000"
    case "9": output += "1001"
    default: break
        }
        bitext = output
                }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "CaptchaSegue" {
            let destinationController:CaptchaViewController = segue.destinationViewController as! CaptchaViewController
            destinationController.inputData = hextext
        }
    }
//    func aes(keydata:NSData,ivdata:NSData,DT:NSData) -> NSData{
//        var keystring = ""
//        var ivstring = ""
//        var DTstring = ""
//        var encstring = ""
//        for i in keydata.arrayOfBytes() {
//            keystring += String(format:"%2X", i)
//        }
//        for j in ivdata.arrayOfBytes() {
//            ivstring += String(format:"%2X", j)
//        }
//        for k in DT.arrayOfBytes() {
//            DTstring += String(format:"%2X", k)
//        }
//        encstring = try! DTstring.aesEncrypt2(keystring, iv: ivstring)
//        return (encstring as NSString).dataUsingEncoding(NSUTF8StringEncoding)!
//    }
}
