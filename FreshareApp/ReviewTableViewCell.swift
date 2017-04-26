//
//  ReviewTableViewCell.swift
//  FreshareApp
//
//  Created by Shuya Ma on 4/19/17.
//  Copyright © 2017 ZhuangYihan. All rights reserved.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {
    
    //static let reuseIdentifier = "cell"


    @IBOutlet weak var review: UILabel!
    
    
    @IBOutlet weak var user_ratings: CosmosView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
