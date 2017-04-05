//
//  SearchTableViewCell.swift
//  FreshareApp
//
//  Created by ZhuangYihan on 4/5/17.
//  Copyright © 2017 ZhuangYihan. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "TableCell"
    
    // MARK: -
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var detailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
