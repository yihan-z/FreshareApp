//
//  StartViewController.swift
//  FreshareApp
//
//  Created by Shuya Ma on 3/21/17.
//  Copyright © 2017 ZhuangYihan. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var freshare_logo: UILabel!
    
    @IBOutlet weak var enter: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        freshare_logo.layer.borderWidth = 5.0
        freshare_logo.layer.borderColor = UIColor.white.cgColor
        freshare_logo.layer.cornerRadius = 5
        freshare_logo.center = CGPoint(x: 185, y: 50)
        
        view.addSubview(freshare_logo)
        
        UIView.animate(withDuration: 2.0, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.0, options: [], animations: {
            self.freshare_logo.center = CGPoint(x: 185, y: 50 + 200)
        }, completion: nil)
        
        //performSegue(withIdentifier: "showfirst", sender: AnyObject)
        
        enter.layer.borderWidth = 3.0
        enter.layer.borderColor = UIColor.white.cgColor
        enter.layer.cornerRadius = 30
        
        view.addSubview(enter)
        UIView.animate(withDuration: 0.5, delay: 1.5, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: [], animations: {
            self.enter.center = CGPoint(x: 185, y: 50 + 200)
        }, completion: nil)
        
        

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
