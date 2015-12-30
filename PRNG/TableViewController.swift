//
//  TableViewController.swift
//  PRNG
//
//  Created by gaoryrt on 15/11/5.
//  Copyright © 2015年 gaoryrt. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    let PRNGchooser = ["Hash链","ANSI X9.17","随机化迭代","扩展随机化迭代"]
    let Infochooser = ["・可选种子、迭代次数与一个迭代Hash函数\n・保证随机性的速度之选","・可选种子、迭代次数、一个种子生成函数、以及一个迭代密码算法\n・美国联邦信息处理标准 FIPS 推荐的标准，是密码强度最高的伪随机数产生器之一","・可选种子、迭代次数与一个迭代单向函数\n・基于压缩规范单向函数及通用散列函数构建，兼并随机性与速度","・可选种子、迭代单向函数和一个 hash 函数\n・使用一般的压缩规范单向函数，扩展随机化迭代，形成伪长度保持函数，在上一代的基础上保持了效率，提升了安全性"]
    var PRNGname = ""




    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain,
            target: nil, action: nil)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source


    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // Return the number of rows in the section.
        return 1
    }
    
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath:
        NSIndexPath) -> UITableViewCell
    {
        let section = indexPath.section
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath:
        indexPath) as! CustomTableViewCell
        // Configure the cell...
        cell.prnglabel!.text = PRNGchooser[section]
        cell.infolabel!.text = Infochooser[section]
        
//        cell.prngimageview!.image = UIImage(named: prngimagechooser[section])
        return cell
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
            // Return the number of sections.
            return 4
    }
    
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
            let mainSettingTableViewController:MainSettingTableViewController = segue.destinationViewController as! MainSettingTableViewController
            mainSettingTableViewController.prngname = self.PRNGname
            
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //下面这行用来取消滑动返回后的选中高亮状态
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let session = indexPath.section
        self.PRNGname = PRNGchooser[session]
        self.performSegueWithIdentifier("showPRNGname", sender: self)
//        
//        print(PRNGname)
    }
    
//    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        var returnstring = ""
//        switch section{
//        case 0: returnstring = "种子选择"
//        case 1: returnstring = "迭代方式"
//        case 2: returnstring = "hash 函数"
//        case 3: returnstring = "Cipher"
//        default: returnstring = ""
//        }
//        
//        return returnstring
//    }
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

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