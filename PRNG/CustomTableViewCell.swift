//
//  CustomTableViewCell.swift
//  PRNG
//
//  Created by gaoryrt on 15/11/5.
//  Copyright © 2015年 gaoryrt. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    @IBOutlet weak var prnglabel:UILabel!
    @IBOutlet weak var infolabel:UILabel!
//    @IBOutlet weak var prngimageview:UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    

}
