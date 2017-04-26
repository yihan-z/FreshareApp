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
    
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        logout.layer.borderWidth = 3.0
        logout.layer.borderColor = UIColor.white.cgColor
        logout.layer.cornerRadius = 33
        
        imageView.image = UIImage(named: "u4")
        imageView.layer.borderWidth = 3.0
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        
        imageView.clipsToBounds = true

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
