//
//  FirstViewController.swift
//  FreshareApp
//
//  Created by ZhuangYihan on 3/6/17.
//  Copyright © 2017 ZhuangYihan. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, GIDSignInUIDelegate {

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        // Uncomment to automatically sign in the user.
        //GIDSignIn.sharedInstance().signInSilently()
        
        // TODO(developer) Configure the sign-in button look/feel
        // ...
    }
    
//    @IBAction func didTapSignOut(sender: AnyObject) {
//        GIDSignIn.sharedInstance().signOut()
//    }
}

