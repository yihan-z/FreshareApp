//
//  ProduceTableViewCell.swift
//  FreshareApp
//
//  Created by ZhuangYihan on 4/23/17.
//  Copyright © 2017 ZhuangYihan. All rights reserved.
//

import UIKit

class ProduceTableViewCell: UITableViewCell {

    //static let reuseIdentifier = "cell"
    
    @IBOutlet weak var pName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
