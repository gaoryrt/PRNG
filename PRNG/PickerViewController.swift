//
//  PickerViewController.swift
//  PRNG
//
//  Created by gaoryrt on 15/11/8.
//  Copyright © 2015年 gaoryrt. All rights reserved.
//

import UIKit
protocol pickerdeleget{
    var choosenIterTime:String{get set}
    var choosenExpanTime:String{get set}
    func reloaddata()
}

class PickerViewController: UIViewController, UIPickerViewDelegate {
    var delegate:pickerdeleget?
    let 可选的最大的数 = 100
    var choosenIterTime = ""
    var choosenExpanTime = ""
    var identifier = ""
    @IBOutlet weak var NumberPicker: UIPickerView!

    var myPickerView: UIPickerView?
    override func viewDidLoad() {
        super.viewDidLoad()
        switch self.identifier{
        case "迭代次数": NumberPicker.selectRow(Int(choosenIterTime)!-1, inComponent: 0, animated: true)
        case "扩展倍数": NumberPicker.selectRow(Int(choosenExpanTime)!-1, inComponent: 0, animated: true)
        default : break
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int)->Int {
        return 可选的最大的数
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var arr:Array = ["1"]
        for i in 2...可选的最大的数{
        arr.append(String(i))
        }
        return arr[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.choosenIterTime = String(row+1)
        switch self.identifier{
        case "迭代次数": delegate?.choosenIterTime = self.choosenIterTime
        case "扩展倍数": delegate?.choosenExpanTime = self.choosenIterTime
        default : break
        }
        delegate!.reloaddata()
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
