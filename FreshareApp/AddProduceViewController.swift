//
//  AddProduceViewController.swift
//  FreshareApp
//
//  Created by Shuya Ma on 4/25/17.
//  Copyright © 2017 ZhuangYihan. All rights reserved.
//

import UIKit

@available(iOS 10.0, *)
class AddProduceViewController: UIViewController {

    @IBOutlet weak var submitBtn: UIButton!
    
    @IBOutlet weak var produce: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        submitBtn.layer.borderWidth = 3.0
        submitBtn.layer.borderColor = UIColor.white.cgColor
        submitBtn.layer.cornerRadius = 15
        


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindToMFfromAdd"{
            
            //            let dest = segue.destination as! FarmDetailViewController
            //            let index = tableView.indexPathForSelectedRow
            //
            //            let farm = farmArray[index!.row]
            //
            //            dest.title = farm.farmName
            //            dest.address = farm.farmAddress
            //            //            dest.ownerName = farm.owner?.name
            //            //            dest.ownerContact = farm.owner?.phone
            //            dest.city = farm.farmCity
            //            dest.postal = farm.farmPostal
            //            dest.latitude = farm.farmLatitude
            //            dest.longitude = farm.farmLongitude
            
            
            let dest = segue.destination as! FarmViewController
            dest.produceArray.append(produce.text!)
            print("?????????????????????????????")
            print(dest.produceArray)
            
            
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }

}
