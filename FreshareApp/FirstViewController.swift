//
//  FirstViewController.swift
//  FreshareApp
//
//  Created by ZhuangYihan on 3/6/17.
//  Copyright © 2017 ZhuangYihan. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, GIDSignInUIDelegate {
    
    
    @IBOutlet weak var login: UIButton!
    
    @IBOutlet weak var register: UIButton!
    
    @IBOutlet weak var guest: UIButton!
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidLoad() {
        
        
        

        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        
        login.layer.borderWidth = 3.0
        login.layer.borderColor = UIColor.white.cgColor
        login.layer.cornerRadius = 22
        
        register.layer.borderWidth = 3.0
        register.layer.borderColor = UIColor.white.cgColor
        register.layer.cornerRadius = 22

        
        guest.layer.borderWidth = 3.0
        guest.layer.borderColor = UIColor.white.cgColor
        guest.layer.cornerRadius = 28

        
        // Uncomment to automatically sign in the user.
        //GIDSignIn.sharedInstance().signInSilently()
        
        // TODO(developer) Configure the sign-in button look/feel
        // ...
    }
    
//    @IBAction func didTapSignOut(sender: AnyObject) {
//        GIDSignIn.sharedInstance().signOut()
//    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
}

