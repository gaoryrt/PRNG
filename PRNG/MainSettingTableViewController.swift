//
//  MainSettingTableViewController.swift
//  PRNG
//
//  Created by gaoryrt on 15/11/6.
//  Copyright © 2015年 gaoryrt. All rights reserved.
//

import UIKit



class MainSettingTableViewController: UITableViewController,settingdeleget,pickerdeleget,keydeleget {
    

    var prngname = ""
    var choosername = ""
    let hashchooser = ["种子来源","迭代Hash函数","迭代次数","点击生成"]
    let ansichooser = ["种子来源","种子生成函数","迭代密码算法","迭代次数","点击生成"]
    let randchooser = ["种子来源","单向函数 f ","单向函数 h ","迭代次数","点击生成"]
    let exrdchooser = ["种子来源","单向函数 f ","单向函数 h ","迭代次数","扩展倍数","点击生成"]
    let hashfooter = ["选择一个或多个陀螺仪信息做为随机数发生器的种子,这一系列陀螺仪信息和来自于一段时间内你手机在空间中摆放的角度和加速度\n你也可以选择添加自定义信息作为种子","Hash函数把任意长度的输入（预映射）通过散列算法，变换成固定长度的输出。这种转换是一种压缩映射，不同的输入可能会散列成相同的输出，但是不可能从散列值来唯一的确定输入值。","迭代次数越多，随机性越高，花费的时间相对较长\n\n",""]
    let ansifooter = ["选择一个或多个陀螺仪信息做为随机数发生器的种子,这一系列陀螺仪信息和来自于一段时间内你手机在空间中摆放的角度和加速度\n你也可以选择添加自定义信息作为种子","种子生成函数用于生成 ANSI X9.17 标准中关键的两个种子（iv/key），这两个种子在每一次迭代中都会用到。每一次迭代中都有三次对称加密，每一次都会由这两个种子来加密","ANSI X9.17 标准所使用的是 DESede 对称加密算法，该算法针对 DES 算法的密钥长度较短以及迭代次数偏少问题做了相应改进，提高了安全强度。","迭代次数越多，随机性越高，花费的时间相对较长\n\n",""]
    let randfooter = ["选择一个或多个陀螺仪信息做为随机数发生器的种子,这一系列陀螺仪信息和来自于一段时间内你手机在空间中摆放的角度和加速度\n你也可以选择添加自定义信息作为种子","单向函数 f 从 多种Hash函数中选择，第一次之后每次迭代的种子都是上一次 h 函数的结果，每一次 h 函数的种子都是 f 函数的结果，同时 f 函数的结果也是输出的一部分","单向函数 h 在迭代中把 f 函数的输出加密后作为种子再次放回整个迭代中作为种子，防止 f 函数多次迭代随机性变小损失熵","迭代次数越多，随机性越高，花费的时间相对较长\n\n",""]
    let exrdfooter = ["选择一个或多个陀螺仪信息做为随机数发生器的种子,这一系列陀螺仪信息和来自于一段时间内你手机在空间中摆放的角度和加速度\n你也可以选择添加自定义信息作为种子","单向函数 f 从 多种Hash函数中选择，第一次之后每次迭代的种子都是上一次 h 函数的结果，每一次 h 函数的种子都是 f 函数的结果，同时 f 函数的结果也是输出的一部分","单向函数 h 在迭代中把 f 函数的输出加密后作为种子再次放回整个迭代中作为种子，防止 f 函数多次迭代随机性变小损失熵","迭代次数越多，随机性越高，花费的时间相对较长","每一次迭代中都会有两次扩展，对 hash 函数压缩的过程进行扩展保持输出的长度，方式 f 多次迭代损失熵令随机性变小\n\n",""]
    var choosenALG = ""
    var choosenK = "点击编辑"
    var choosenFuncH = "SHA-256"
    var choosenFuncEx = "SHA-256"
    var choosenFuncEDE = "EDE"
    var choosenIterTime = "1"
    var choosenExpanTime = "1"
    func reloaddata() {
        self.tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = self.prngname

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

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        var sectionnumber = ansichooser.count
        switch prngname{
        case "Hash链": sectionnumber = hashchooser.count
        case "扩展随机化迭代": sectionnumber = exrdchooser.count
        case "随机化迭代": sectionnumber = randchooser.count
        default: sectionnumber = ansichooser.count
        }
        return sectionnumber
//        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let section = indexPath.section
        let cell = tableView.dequeueReusableCellWithIdentifier("mainsettingcell", forIndexPath: indexPath)
        switch prngname{
        case "Hash链":
            cell.textLabel?.text = hashchooser[section]
        case "ANSI X9.17": cell.textLabel?.text = ansichooser[section]
        case "随机化迭代": cell.textLabel?.text = randchooser[section]
        case "扩展随机化迭代": cell.textLabel?.text = exrdchooser[section]
        default:  break
        }
        
        switch cell.textLabel!.text!{
        case "种子来源" : cell.detailTextLabel?.text = choosenK
        case "迭代密码算法" : cell.detailTextLabel?.text = choosenFuncEDE
        case "单向函数 f " : cell.detailTextLabel?.text = choosenFuncEx
        case "单向函数 h " : cell.detailTextLabel?.text = choosenFuncH
        case "迭代Hash函数": cell.detailTextLabel?.text = choosenFuncH
        case "种子生成函数" : cell.detailTextLabel?.text = choosenFuncH
        case "迭代次数":  cell.detailTextLabel?.text = choosenIterTime
        case "扩展倍数":  cell.detailTextLabel?.text = choosenExpanTime
        default: break
        }
        
        if cell.textLabel!.text == "点击生成" {
            cell.textLabel?.textColor = UIColor(red: 30/255.0, green: 130/255.0, blue: 250/255.0, alpha: 1.0)
            cell.detailTextLabel?.text = ""
            cell.accessoryType = UITableViewCellAccessoryType.None
        }
        else {
            cell.textLabel?.textColor = UIColor.blackColor()
        }
        return cell
    }

    override func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        var footer = []
        switch prngname{
        case "Hash链": footer = hashfooter
        case "ANSI X9.17": footer = ansifooter
        case "随机化迭代": footer = randfooter
        case "扩展随机化迭代": footer = exrdfooter
        default:  break
        }
        return footer[section] as? String
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        choosenALG = prngname
        switch self.choosername{
        case "种子来源": let keycontroller:SeedChooserViewController = segue.destinationViewController as! SeedChooserViewController
                        keycontroller.choosenK = self.choosenK
        case "点击生成": let outputcontroller:OutputViewController = segue.destinationViewController as! OutputViewController
                        outputcontroller.choosenALG = prngname
                        outputcontroller.choosenFuncEDE = self.choosenFuncEDE
                        outputcontroller.choosenFuncEx = self.choosenFuncEx
                        outputcontroller.choosenFuncH = self.choosenFuncH
                        outputcontroller.choosenExpanTime = self.choosenExpanTime
                        outputcontroller.choosenIterTime = self.choosenIterTime
                        outputcontroller.choosenK = self.choosenK
                        break
        case "迭代次数": let pickercontroller:PickerViewController = segue.destinationViewController as! PickerViewController
                        pickercontroller.identifier = "迭代次数"
                        pickercontroller.choosenIterTime = self.choosenIterTime
        case "扩展倍数": let pickercontroller:PickerViewController = segue.destinationViewController as! PickerViewController
                        pickercontroller.identifier = "扩展倍数"
                        pickercontroller.choosenExpanTime = self.choosenExpanTime
        default:
        let choosechooser:ChooseChooserTableViewController = segue.destinationViewController as! ChooseChooserTableViewController
            choosechooser.choosername = self.choosername
            choosechooser.choosenFuncEDE = self.choosenFuncEDE
            choosechooser.choosenFuncEx = self.choosenFuncEx
            choosechooser.choosenFuncH = self.choosenFuncH
        }
        switch segue.identifier! {
        case "showSeedChooser": let keycontroller:SeedChooserViewController = segue.destinationViewController as! SeedChooserViewController
            keycontroller.delegate = self
        case "showChooser": let choosechooser:ChooseChooserTableViewController = segue.destinationViewController as! ChooseChooserTableViewController
            choosechooser.delegate = self
        case "showPicker":  let pickercontroller:PickerViewController = segue.destinationViewController as! PickerViewController
            pickercontroller.delegate = self
        default:break
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //下面这行用来取消滑动返回后的选中高亮状态
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let session = indexPath.section
        
        switch prngname{
        case "Hash链": self.choosername = hashchooser[session]
        case "ANSI X9.17": self.choosername = ansichooser[session]
        case "随机化迭代": self.choosername = randchooser[session]
        case "扩展随机化迭代": self.choosername = exrdchooser[session]
        default:  break
        }
        
        switch self.choosername{
        case "种子来源": self.performSegueWithIdentifier("showSeedChooser", sender: self)
        case "点击生成": self.performSegueWithIdentifier("showAnswer", sender: self)
        case "迭代次数": self.performSegueWithIdentifier("showPicker", sender: self)
        case "扩展倍数": self.performSegueWithIdentifier("showPicker", sender: self)
        default: self.performSegueWithIdentifier("showChooser", sender: self)
        }
    }
    
     @IBAction func back(segue: UIStoryboardSegue) {}
    


}
