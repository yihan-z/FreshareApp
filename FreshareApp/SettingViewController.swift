//
//  SettingViewController.swift
//  FreshareApp
//
//  Created by Shuya Ma on 3/22/17.
//  Copyright © 2017 ZhuangYihan. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var logout: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        logout.layer.borderWidth = 3.0
        logout.layer.borderColor = UIColor.white.cgColor
        logout.layer.cornerRadius = 33

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
