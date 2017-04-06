//
//  FarmViewController.swift
//  FreshareApp
//
//  Created by ZhuangYihan on 3/7/17.
//  Copyright © 2017 ZhuangYihan. All rights reserved.
//

import UIKit

class FarmDetailViewController: UIViewController {
    
    @IBOutlet weak var ProduceReviewSegment: UISegmentedControl!
    @IBOutlet weak var contactBtn: UIButton!
    
    @IBOutlet weak var farmName: UILabel!
    @IBOutlet weak var farmOwnerName: UILabel!
    @IBOutlet weak var farmAddress: UILabel!
    @IBOutlet weak var farmCityPost: UILabel!
    
    var name:String!
    var address:String!
    var ownerName:String!
    var ownerContact:String!
    var city:String!
    var postal:String!
    var latitude:Float!
    var longitude:Float!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contactBtn.layer.borderWidth = 3.0
        contactBtn.layer.borderColor = UIColor(red:0.51, green:0.82, blue:0.38, alpha:1.0).cgColor
        contactBtn.layer.cornerRadius = 15

        
        // Do any additional setup after loading the view.
        farmName.text = name
        farmOwnerName.text = ownerName
        farmAddress.text = address
        let citypost:String = city + ", " + postal
        
        farmCityPost.text = citypost
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ChangeSection(_ sender: AnyObject) {
        
        
        
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
