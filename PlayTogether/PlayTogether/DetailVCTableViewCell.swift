//
//  DetailVCTableViewCell.swift
//  PlayTogether
//
//  Created by Jimmy on 2017/7/11.
//  Copyright © 2017年 Jimmy. All rights reserved.
//

import UIKit

class DetailVCTableViewCell: UITableViewCell {

    @IBOutlet weak var message: UILabel!
    
    @IBOutlet weak var messageTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
