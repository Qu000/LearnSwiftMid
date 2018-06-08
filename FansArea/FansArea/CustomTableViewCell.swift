//
//  CustomTableViewCell.swift
//  FansArea
//
//  Created by qujiahong on 2018/6/2.
//  Copyright © 2018年 瞿嘉洪. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    ///缩略图
    @IBOutlet weak var thumbImage: UIImageView!
    ///name
    @IBOutlet weak var nameLab: UILabel!
    ///省份
    @IBOutlet weak var proviceLab: UILabel!
    ///地区
    @IBOutlet weak var partLab: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
