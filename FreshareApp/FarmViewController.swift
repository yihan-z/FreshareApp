//
//  FarmViewController.swift
//  FreshareApp
//
//  Created by ZhuangYihan on 3/7/17.
//  Copyright © 2017 ZhuangYihan. All rights reserved.
//

import UIKit
import FirebaseAuth

@available(iOS 10.0, *)
class FarmViewController: UIViewController {


    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    @IBOutlet weak var edit_info: UIButton!
    @IBOutlet weak var add_pro: UIButton!
    
    @IBOutlet weak var farmName: UILabel!
    @IBOutlet weak var farmAddress: UILabel!
    
    @IBOutlet weak var farmPic: UIImageView!
    
    @IBOutlet weak var segmentTable: UITableView!
    
    @IBOutlet weak var createFarmBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        createFarmBtn.isHidden = false
        // check if Google/Firebase logged in
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if appDelegate.signedIn == true || FIRAuth.auth()?.currentUser != nil {
            // user is logged in
        } else {
            //User Not logged in
        }
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
    
    @IBAction func createFarm(_ sender: Any) {
        segmentControl.isHidden = false
        
        edit_info.isHidden = false
        add_pro.isHidden = false
        
        farmName.isHidden = false
        farmAddress.isHidden = false
        
        farmPic.isHidden = false
        
        segmentTable.isHidden = false
        
        createFarmBtn.isHidden = true
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
