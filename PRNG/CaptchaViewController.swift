//
//  CaptchaViewController.swift
//  PRNG
//
//  Created by gaoryrt on 15/12/18.
//  Copyright © 2015年 gaoryrt. All rights reserved.
//

import UIKit

class CaptchaViewController: UIViewController {
    @IBOutlet weak var aLabel: UILabel!
    @IBOutlet weak var bLabel: UILabel!
    @IBOutlet weak var cLabel: UILabel!
    @IBOutlet weak var dLabel: UILabel!
    @IBOutlet weak var BGImage: UIImageView!
    @IBOutlet weak var trueLabel: UILabel!

    var inputData = ""
    var usingData = ""
    var startNumber = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        usingData = (inputData as NSString).substringWithRange(NSMakeRange(0, 18))
        // Do any additional setup after loading the view.
        let typea = (usingData as NSString).substringWithRange(NSMakeRange(0, 1))
        let typeb = (usingData as NSString).substringWithRange(NSMakeRange(1, 1))
        let typec = (usingData as NSString).substringWithRange(NSMakeRange(2, 1))
        let typed = (usingData as NSString).substringWithRange(NSMakeRange(3, 1))
        let spina = (usingData as NSString).substringWithRange(NSMakeRange(4, 1))
        let spinb = (usingData as NSString).substringWithRange(NSMakeRange(5, 1))
        let spinc = (usingData as NSString).substringWithRange(NSMakeRange(6, 1))
        let spind = (usingData as NSString).substringWithRange(NSMakeRange(7, 1))
        let BGimage = (usingData as NSString).substringWithRange(NSMakeRange(8, 1))
        let letta = (usingData as NSString).substringWithRange(NSMakeRange(9, 2))
        let lettb = (usingData as NSString).substringWithRange(NSMakeRange(11, 2))
        let lettc = (usingData as NSString).substringWithRange(NSMakeRange(13, 2))
        let lettd = (usingData as NSString).substringWithRange(NSMakeRange(15, 2))
                
        changetypex(typea,xLabel: aLabel)
        changetypex(typeb,xLabel: bLabel)
        changetypex(typec,xLabel: cLabel)
        changetypex(typed,xLabel: dLabel)
        changespinx(spina,xLabel: aLabel)
        changespinx(spinb,xLabel: bLabel)
        changespinx(spinc,xLabel: cLabel)
        changespinx(spind,xLabel: dLabel)
        switch BGimage{
        case "0","1","2","3": BGImage.image = UIImage(named: "gbi1")
        case "4","5","6","7": BGImage.image = UIImage(named: "bgi2")
        case "8","9","A","B": BGImage.image = UIImage(named: "bgi3")
        case "C","D","E","F": BGImage.image = UIImage(named: "bgi4")
        default:BGImage.image = UIImage(named: "bgi4")
        }
        changelettx(letta, xLabel: aLabel)
        changelettx(lettb, xLabel: bLabel)
        changelettx(lettc, xLabel: cLabel)
        changelettx(lettd, xLabel: dLabel)
        print(aLabel.text!,bLabel.text!,cLabel.text!,dLabel.text!)
        trueLabel.text = aLabel.text! + bLabel.text! + cLabel.text! + dLabel.text!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func changetypex(typea:String,xLabel:UILabel) {
        switch typea{
            case "0","1","2","3": xLabel.font = UIFont(name:"Chalkduster", size:98)
            case "4","5","6","7": xLabel.font = UIFont(name:"Academy Engraved LET", size:98)
            case "8","9","A","B": xLabel.font = UIFont(name:"Avenir Next Condensed", size:98)
            case "C","D","E","F": xLabel.font = UIFont(name:"Party LET", size:98)
        default:break
        }
        
    }
    
    func changelettx(typea:String,xLabel:UILabel) {
        switch typea{
//        case "00", "01", "02", "03", "04", "05", "06": xLabel.text = "0"
        case "07", "08", "09", "0A", "0B", "0C", "0D": xLabel.text = "1"
        case "0E", "0F", "10", "11", "12", "13", "14": xLabel.text = "2"
        case "15", "16", "17", "18", "19", "1A", "1B": xLabel.text = "3"
        case "1C", "1D", "1E", "1F", "20", "21", "22": xLabel.text = "4"
//        case "23", "24", "25", "26", "27", "28", "29": xLabel.text = "5"
        case "2A", "2B", "2C", "2D", "2E", "2F", "30": xLabel.text = "6"
        case "31", "32", "33", "34", "35", "36", "37": xLabel.text = "7"
        case "38", "39", "3A", "3B", "3C", "3D", "3E": xLabel.text = "8"
        case "3F", "40", "41", "42", "43", "44", "45": xLabel.text = "9"
        case "46", "47", "48", "49", "4A", "4B", "4C": xLabel.text = "Q"
        case "4D", "4E", "4F", "50", "51", "52", "53": xLabel.text = "W"
        case "54", "55", "56", "57", "58", "59", "5A": xLabel.text = "E"
        case "5B", "5C", "5D", "5E", "5F", "60", "61": xLabel.text = "R"
        case "62", "63", "64", "65", "66", "67", "68": xLabel.text = "T"
        case "69", "6A", "6B", "6C", "6D", "6E", "6F": xLabel.text = "Y"
        case "70", "71", "72", "73", "74", "75", "76": xLabel.text = "U"
        case "77", "78", "79", "7A", "7B", "7C", "7D": xLabel.text = "I"
//        case "7E", "7F", "80", "81", "82", "83", "84": xLabel.text = "O"
        case "85", "86", "87", "88", "89", "8A", "8B": xLabel.text = "P"
        case "8C", "8D", "8E", "8F", "90", "91", "92": xLabel.text = "A"
//        case "93", "94", "95", "96", "97", "98", "99": xLabel.text = "S"
        case "9A", "9B", "9C", "9D", "9E", "9F", "A0": xLabel.text = "D"
        case "A1", "A2", "A3", "A4", "A5", "A6", "A7": xLabel.text = "F"
        case "A8", "A9", "AA", "AB", "AC", "AD", "AE": xLabel.text = "G"
        case "AF", "B0", "B1", "B2", "B3", "B4", "B5": xLabel.text = "H"
        case "B6", "B7", "B8", "B9", "BA", "BB", "BC": xLabel.text = "J"
        case "BD", "BE", "BF", "C0", "C1", "C2", "C3": xLabel.text = "K"
        case "C4", "C5", "C6", "C7", "C8", "C9", "CA": xLabel.text = "L"
        case "CB", "CC", "CD", "CE", "CF", "D0", "D1": xLabel.text = "Z"
        case "D2", "D3", "D4", "D5", "D6", "D7", "D8": xLabel.text = "X"
        case "D9", "DA", "DB", "DC", "DD", "DE", "DF": xLabel.text = "C"
        case "E0", "E1", "E2", "E3", "E4", "E5", "E6": xLabel.text = "V"
        case "E7", "E8", "E9", "EA", "EB", "EC", "ED": xLabel.text = "B"
        case "EE", "EF", "F0", "F1", "F2", "F3", "F4": xLabel.text = "N"
        case "F5", "F6", "F7", "F8", "F9", "FA", "FB": xLabel.text = "M"
        default:break
        }
    }
    
    func changespinx(typea:String,xLabel:UILabel) {
        switch typea{
        case "0","1": xLabel.transform = CGAffineTransformMakeRotation(0.1)
        case "2","3": xLabel.transform = CGAffineTransformMakeRotation(0.2)
        case "4","5": xLabel.transform = CGAffineTransformMakeRotation(0.3)
        case "6","7": xLabel.transform = CGAffineTransformMakeRotation(0.4)
        case "8","9": xLabel.transform = CGAffineTransformMakeRotation(-0.1)
        case "A","B": xLabel.transform = CGAffineTransformMakeRotation(-0.2)
        case "C","D": xLabel.transform = CGAffineTransformMakeRotation(-0.3)
        case "E","F": xLabel.transform = CGAffineTransformMakeRotation(-0.4)
        default:break
        }
    }
    
    
    @IBAction func changeOne(sender: AnyObject) {
        startNumber += 9
        usingData = (inputData as NSString).substringWithRange(NSMakeRange(startNumber, 18))
        print(usingData)
        let typea = (usingData as NSString).substringWithRange(NSMakeRange(0, 1))
        let typeb = (usingData as NSString).substringWithRange(NSMakeRange(1, 1))
        let typec = (usingData as NSString).substringWithRange(NSMakeRange(2, 1))
        let typed = (usingData as NSString).substringWithRange(NSMakeRange(3, 1))
        let spina = (usingData as NSString).substringWithRange(NSMakeRange(4, 1))
        let spinb = (usingData as NSString).substringWithRange(NSMakeRange(5, 1))
        let spinc = (usingData as NSString).substringWithRange(NSMakeRange(6, 1))
        let spind = (usingData as NSString).substringWithRange(NSMakeRange(7, 1))
        let BGimage = (usingData as NSString).substringWithRange(NSMakeRange(8, 1))
        let letta = (usingData as NSString).substringWithRange(NSMakeRange(9, 2))
        let lettb = (usingData as NSString).substringWithRange(NSMakeRange(11, 2))
        let lettc = (usingData as NSString).substringWithRange(NSMakeRange(13, 2))
        let lettd = (usingData as NSString).substringWithRange(NSMakeRange(15, 2))
        
        changetypex(typea,xLabel: aLabel)
        changetypex(typeb,xLabel: bLabel)
        changetypex(typec,xLabel: cLabel)
        changetypex(typed,xLabel: dLabel)
        changespinx(spina,xLabel: aLabel)
        changespinx(spinb,xLabel: bLabel)
        changespinx(spinc,xLabel: cLabel)
        changespinx(spind,xLabel: dLabel)
        switch BGimage{
        case "0","1","2","3": BGImage.image = UIImage(named: "gbi1")
        case "4","5","6","7": BGImage.image = UIImage(named: "bgi2")
        case "8","9","A","B": BGImage.image = UIImage(named: "bgi3")
        case "C","D","E","F": BGImage.image = UIImage(named: "bgi4")
        default:BGImage.image = UIImage(named: "bgi4")
        }
        changelettx(letta, xLabel: aLabel)
        changelettx(lettb, xLabel: bLabel)
        changelettx(lettc, xLabel: cLabel)
        changelettx(lettd, xLabel: dLabel)
        print(aLabel.text!,bLabel.text!,cLabel.text!,dLabel.text!)
        trueLabel.text = aLabel.text! + bLabel.text! + cLabel.text! + dLabel.text!
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
