//
//  SeedChooserViewController.swift
//  PRNG
//
//  Created by gaoryrt on 15/11/9.
//  Copyright © 2015年 gaoryrt. All rights reserved.
//

import UIKit
import CoreMotion
var gyrostring = ""

protocol keydeleget{
    var choosenK:String{get set}
    func reloaddata()
}

class SeedChooserViewController: UIViewController, UITextFieldDelegate{
    let motionManager = CMMotionManager()
    var delegate:keydeleget?
    var choosenK = ""
    var choosenXYZ = 0
    var choosenInput = ""
    @IBOutlet weak var XSwitch: UISwitch!
    @IBOutlet weak var YSwitch: UISwitch!
    @IBOutlet weak var ZSwitch: UISwitch!
    @IBOutlet weak var SelfSwitch: UISwitch!
    @IBOutlet weak var ImageBehindText: UIImageView!
    @IBOutlet weak var TextField: UITextField!
    @IBOutlet weak var keyDisplayLable: UILabel!
    @IBOutlet weak var xGyroLabel: UILabel!
    @IBOutlet weak var yGyroLabel: UILabel!
    @IBOutlet weak var zGyroLabel: UILabel!
    
    func outputRotationData(rotation:CMRotationRate)
    {
        
        let xtext = NSString(format:"%.12f", abs(rotation.x) ).substringFromIndex(3)
        self.xGyroLabel.text = xtext
        let ytext = NSString(format:"%.12f", abs(rotation.y) ).substringFromIndex(3)
        self.yGyroLabel.text = ytext
        let ztext = NSString(format:"%.12f", abs(rotation.z) ).substringFromIndex(3)
        self.zGyroLabel.text = ztext
        
        switch choosenXYZ {
        
        case 1: gyrostring = (ztext as String) + gyrostring
        case 2: gyrostring = (ytext as String) + gyrostring
        case 3: gyrostring = (ytext as String) + (ztext as String) + gyrostring
        case 4: gyrostring = (xtext as String) + gyrostring
        case 5: gyrostring = (xtext as String) + (ztext as String) + gyrostring
        case 6: gyrostring = (xtext as String) + (ytext as String) + gyrostring
        case 7: gyrostring = (xtext as String) + (ytext as String) + (ztext as String) + gyrostring
        default: break
        }
        keyDisplayLable.text = self.choosenInput + gyrostring
        refresh()
    }
    
    
    
    func MMg()
    {
        if motionManager.gyroAvailable {
            motionManager.deviceMotionUpdateInterval = 0.08;
            motionManager.startDeviceMotionUpdates()
            motionManager.startGyroUpdates()
            motionManager.gyroUpdateInterval = 0.08
            motionManager.startGyroUpdatesToQueue(NSOperationQueue.currentQueue()!) {
                [weak self] (gyroData, error) in
                self?.outputRotationData(gyroData!.rotationRate)

                if error != nil {
                    print("\(error)")
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        gyrostring = ""
        MMg()
        TextField.delegate = self
        self.view.addSubview(TextField)
        SelfSwitch.addTarget(self, action: Selector("SelfstateChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        XSwitch.addTarget(self, action: Selector("XstateChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        YSwitch.addTarget(self, action: Selector("YstateChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        ZSwitch.addTarget(self, action: Selector("ZstateChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        
        self.TextField.alpha = 0
            self.ImageBehindText.alpha = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func disappearAnimation()
    {
        TextField.alpha = 1;
        ImageBehindText.alpha = 1;
        //设置动画效果，动画时间长度 1 秒。
        UIView.animateWithDuration(0.4, delay:0.01,
            options:UIViewAnimationOptions.CurveEaseInOut, animations:
            {
                ()-> Void in
            },
            completion:{
                (finished:Bool) -> Void in
                UIView.animateWithDuration(0.4, animations:{
                    ()-> Void in
                    self.TextField.alpha = 0
                    self.ImageBehindText.alpha = 0
                })
        })
        
    }
    
    func appearAnimation()
    {
        TextField.alpha = 0;
        ImageBehindText.alpha = 0;
        //设置动画效果，动画时间长度 1 秒。
        UIView.animateWithDuration(0.4, delay:0.01,
            options:UIViewAnimationOptions.CurveEaseInOut, animations:
            {
                ()-> Void in
            },
            completion:{
                (finished:Bool) -> Void in
                UIView.animateWithDuration(0.4, animations:{
                    ()-> Void in
                    self.TextField.alpha = 1
                    self.ImageBehindText.alpha = 1
                })
        })
        
    }
    
    func SelfstateChanged(switchState: UISwitch) {
        if switchState.on {
            appearAnimation()
            refresh()
        } else {
            disappearAnimation()
            refresh()
        }
    }

    
    
    func XstateChanged(switchState: UISwitch) {
        if switchState.on {
            self.choosenXYZ += 4
            MMg()
            
            refresh()
        } else {
            self.choosenXYZ -= 4
            refresh()
        }
    }
    
    func YstateChanged(switchState: UISwitch) {
        if switchState.on {
            self.choosenXYZ += 2
            MMg()
            
            refresh()
        } else {
            self.choosenXYZ -= 2
            refresh()
        }
    }
    
    func ZstateChanged(switchState: UISwitch) {
        if switchState.on {
            self.choosenXYZ += 1
            MMg()
            
            refresh()
        } else {
            self.choosenXYZ -= 1
            refresh()
        }
    }
    
    
    func textFieldShouldReturn(textField:UITextField) -> Bool
    {
        //收起键盘
        textField.resignFirstResponder()
        //打印出文本框中的值
        self.choosenInput = TextField.text!
        refresh()
        return true;
    }
    
    func refresh() {
        delegate?.choosenK = self.choosenInput + gyrostring
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
