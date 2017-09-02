//
//  customerTableViewCell.swift
//  PlayTogether
//
//  Created by Jimmy on 2017/7/6.
//  Copyright © 2017年 Jimmy. All rights reserved.
//

import UIKit

class customerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var Adress: UILabel!
    @IBOutlet weak var location: UILabel!
    
    @IBOutlet weak var distance: UILabel! 

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
