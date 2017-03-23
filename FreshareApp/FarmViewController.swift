//
//  FarmViewController.swift
//  FreshareApp
//
//  Created by ZhuangYihan on 3/7/17.
//  Copyright © 2017 ZhuangYihan. All rights reserved.
//

import UIKit

class FarmViewController: UIViewController {

    @IBOutlet weak var ProduceReviewSegment: UISegmentedControl!
    
    @IBOutlet weak var edit_info: UIButton!
    
    
    @IBOutlet weak var add_pro: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        edit_info.layer.borderWidth = 3.0
        edit_info.layer.borderColor = UIColor(red:0.51, green:0.82, blue:0.38, alpha:1.0).cgColor
        edit_info.layer.cornerRadius = 15
        
        add_pro.layer.borderWidth = 3.0
        add_pro.layer.borderColor = UIColor(red:0.51, green:0.82, blue:0.38, alpha:1.0).cgColor
        add_pro.layer.cornerRadius = 15

        // Do any additional setup after loading the view.
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
