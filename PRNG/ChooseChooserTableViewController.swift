//
//  ChooseChooserTableViewController.swift
//  PRNG
//
//  Created by gaoryrt on 15/11/7.
//  Copyright © 2015年 gaoryrt. All rights reserved.
//

import UIKit

protocol settingdeleget{
    var choosenFuncH:String{get set}
    var choosenFuncEx:String{get set}
    var choosenFuncEDE:String{get set}
    func reloaddata()
}

class ChooseChooserTableViewController: UITableViewController {
    
    
    var delegate:settingdeleget?
    var choosername = ""
    let hashchooser = ["MD5","SHA-1","SHA-224","SHA-256","SHA-384","SHA-512"]
    let cyprchooser = ["EDE"]
    let hashfooter = [
        "MD5 (Message Digest Algorithm MD5 消息摘要算法第五版) 以512位分组来处理输入的信息，且每一分组又被划分为16个32位子分组，经过了一系列的处理后，算法的输出由四个32位分组组成，将这四个32位分组级联后将生成一个128位散列值。MD5的作用是让大容量信息在用数字签名软件签署私人密钥前被\"压缩\"成一种保密的格式，即将一个任意长度的字节串变换成一定长的十六进制数字串",
        "SHA-1(Secure Hash Algorithm 安全哈希算法)对于长度小于2^64位的消息，SHA-1会产生一个160位的消息摘要。SHA算法的思想是接收一段明文，然后以一种不可逆的方式将它转换成一段（通常更小）密文，也可以简单的理解为取一串输入码（称为预映射或信息），并把它们转化为长度较短、位数固定的输出序列即散列值（也称为信息摘要或信息认证代码）的过程",
        "SHA-224(Secure Hash Algorithm 安全哈希算法)相较于其他 SHA 家族的散列算法，SHA-224会产生一个224位的消息摘要。",
        "SHA-256(Secure Hash Algorithm 安全哈希算法)相较于其他 SHA 家族的散列算法，SHA-256会产生一个256位的消息摘要。",
        "SHA-384(Secure Hash Algorithm 安全哈希算法)相较于其他 SHA 家族的散列算法，SHA-384会产生一个384位的消息摘要。",
        "SHA-512(Secure Hash Algorithm 安全哈希算法)相较于其他 SHA 家族的散列算法，SHA-512会产生一个512位的消息摘要。"]
    let cyprfooter = ["EDE"]
    
    var choosenFuncH = "SHA-256"
    var choosenFuncEx = "SHA-256"
    var choosenFuncEDE = "EDE"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = self.choosername+"选择"
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        var sectionnumber = hashchooser.count
        if choosername == "迭代密码算法"{
            sectionnumber = cyprchooser.count
        }
        return sectionnumber
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let section = indexPath.section
        let cell = tableView.dequeueReusableCellWithIdentifier("settingcell", forIndexPath: indexPath)
        switch choosername{
        case "迭代密码算法": cell.textLabel?.text = cyprchooser[section]
        if cell.textLabel?.text == choosenFuncEDE {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            }
        else {
            cell.accessoryType = UITableViewCellAccessoryType.None
            }
        case "单向函数 f ": cell.textLabel?.text = hashchooser[section]
        if cell.textLabel?.text == choosenFuncEx {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            }
        else {
            cell.accessoryType = UITableViewCellAccessoryType.None
            }
        default: cell.textLabel?.text = hashchooser[section]
        if cell.textLabel?.text == choosenFuncH {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            }
        else {
            cell.accessoryType = UITableViewCellAccessoryType.None
            }
        }
        
        // Configure the cell...

        return cell
    }

    override func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        var footer = []
        switch choosername{
        case "迭代密码算法": footer = cyprfooter
        default: footer = hashfooter
        }
        return footer[section] as? String
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       
        let session = indexPath.section
       
        //下面这行用来取消滑动返回后的选中高亮状态
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        switch choosername{
        case "迭代密码算法" :delegate?.choosenFuncEDE = cyprchooser[session]
            choosenFuncEDE = cyprchooser[session]
        case "单向函数 f " : delegate?.choosenFuncEx = hashchooser[session]
            choosenFuncEx = hashchooser[session]
        case "单向函数 h " : delegate?.choosenFuncH = hashchooser[session]
            choosenFuncH = hashchooser[session]
        case "迭代Hash函数" : delegate?.choosenFuncH = hashchooser[session]
            choosenFuncH = hashchooser[session]
        case "种子生成函数" : delegate?.choosenFuncH = hashchooser[session]
            choosenFuncH = hashchooser[session]
        default: break
        }
        //取消选中的样式
        let cell:UITableViewCell!=tableView.cellForRowAtIndexPath(indexPath)

        //遍历取消所有单元格样式
        var arry=tableView.visibleCells;
        for(var  i=0;i<arry.count;i++){
            let cells:UITableViewCell=arry[i] ;
            cells.accessoryType=UITableViewCellAccessoryType.None
        }
        
        //设置选中的单元格样式-checkmark
        cell.accessoryType=UITableViewCellAccessoryType.Checkmark;
        
        delegate!.reloaddata()
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
