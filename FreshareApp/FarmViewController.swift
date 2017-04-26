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
    
    @IBOutlet weak var add_pro: UIButton!
    
    @IBOutlet weak var farmName: UILabel!
    
    
    @IBOutlet weak var farmAddress: UILabel!
    
    @IBOutlet weak var farmContact: UILabel!
    @IBOutlet weak var farmCity: UILabel!
    
    @IBOutlet weak var createFarmBtn: UIButton!
    @IBOutlet weak var farmZip: UILabel!

    @IBOutlet weak var farmPic: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBAction func listChanged(_ sender: Any) {
        
        print("**********************")
        print(segmentControl.selectedSegmentIndex)
        
        switch segmentControl.selectedSegmentIndex
        {
        case 0:
            segmentIndex = 0
            print("Produce")
            
        case 1:
            segmentIndex = 1
            print("Review")
            
        default:
            break
        }
        self.tableView.reloadData()
        
    }
    @IBAction func unwindToMyFarm(segue: UIStoryboardSegue){
        
    }
    
    
    var segmentIndex:Int = 0
    
    var produceArray = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red:0.51, green:0.82, blue:0.38, alpha:1.0)
        
        createFarmBtn.isHidden = false
        
        createFarmBtn.layer.borderWidth = 3.0
        createFarmBtn.layer.borderColor = UIColor.white.cgColor
        createFarmBtn.layer.cornerRadius = 22
        createFarmBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
        
        // check if Google/Firebase logged in
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if appDelegate.signedIn == true || FIRAuth.auth()?.currentUser != nil {
            // user is logged in
        } else {
            //User Not logged in
        }

        
        add_pro.layer.borderWidth = 3.0
        add_pro.layer.borderColor = Colors.mainGreen.cgColor
        add_pro.layer.cornerRadius = 15

        // Do any additional setup after loading the view.
        
        farmPic.layer.borderWidth = 3.0
        farmPic.layer.borderColor = Colors.mainGreen.cgColor
        farmPic.clipsToBounds = true
        
        
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    
    @IBAction func createFarm(_ sender: Any) {
        segmentControl.isHidden = false
        
        add_pro.isHidden = false
        
        farmName.isHidden = false
        farmAddress.isHidden = false
        
        farmZip.isHidden = false
        farmCity.isHidden = false
        farmContact.isHidden = false
        
        farmPic.isHidden = false
        
        tableView.isHidden = false
        
        createFarmBtn.isHidden = true
        
        self.view.backgroundColor = UIColor.white
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


@available(iOS 10.0, *)
extension FarmViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (segmentIndex == 0){ // produce list
            print("@@@@@@@@@@@@@@@@@@@@@@@")
            print(produceArray)
            return produceArray.count
        }

        else{
            return 0
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("******populating table")
        //        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReviewTableViewCell.reuseIdentifier, for: indexPath) as? ReviewTableViewCell else {
        //            fatalError("Unexpected Index Path")
        //        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddProduceCell") as! AddProduceTableViewCell
        
        let produce = produceArray[indexPath.row]
        
        cell.prodceName.text = produce
        print("&&&&&&&&&&&&&&&&&&&&&&")
        print(cell.prodceName.text)
        
        
//        if (segmentIndex == 0){ // produce list
//            let produce = produceArray[indexPath.row]
//            
//            print("fetching indexPath \(indexPath.row)")
//            print("review \(produce.name)")
//            // Configure Cell
//            cell.review.text = produce.name
//            cell.user_ratings.isHidden = true
//            //            cell.user_ratings.settings.updateOnTouch = false
//        }
//        else { // review list
//            
//            let review = reviewArray[indexPath.row]
//            let ratingScore = ratingArray[indexPath.row]
//            
//            //print(ratingScore)
//            
//            print("fetching indexPath \(indexPath.row)")
//            print("review \(review.content)")
//            // Configure Cell
//            cell.review.text = review.content
//            cell.user_ratings.isHidden = false
//            
//            cell.user_ratings.rating = ratingScore
//            cell.user_ratings.settings.updateOnTouch = false
//        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            
            
            if let tv=tableView
            {
                
                
                
                produceArray.remove(at: indexPath!.row)
                tv.deleteRows(at: [indexPath as IndexPath], with: .fade)
                
                
                
            }
        }
    }
    
    
}

