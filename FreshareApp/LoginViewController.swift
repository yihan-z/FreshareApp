//
//  LoginViewController.swift
//  FreshareApp
//
//  Created by Shuya Ma on 4/24/17.
//  Copyright © 2017 ZhuangYihan. All rights reserved.
//

import UIKit


@available(iOS 10.0, *)
class LoginViewController: UIViewController {

    
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(named: "u4")
        imageView.layer.borderWidth = 3.0
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = imageView.frame.size.width / 2

        imageView.clipsToBounds = true

        
        transition()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func transition()
    {
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let secondViewController = storyboard.instantiateViewController(withIdentifier: "map") as UIViewController
//        present(secondViewController, animated: true, completion: nil)

        let secondVC = MapViewController()
        navigationController?.pushViewController(secondVC, animated: true)
       
        
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
