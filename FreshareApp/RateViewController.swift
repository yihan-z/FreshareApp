//
//  RateViewController.swift
//  FreshareApp
//
//  Created by Shuya Ma on 4/18/17.
//  Copyright © 2017 ZhuangYihan. All rights reserved.
//

import UIKit
import CoreData

@available(iOS 10.0, *)
class RateViewController: UIViewController, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var reviewText: UITextView!
  
    @IBOutlet weak var ratingScore: CosmosView!
    
    
    @IBOutlet weak var submitBtn: UIButton!
    
    @IBOutlet weak var FarmName: UILabel!
    

    
    var farm = Farm()
//
//    var name:String!
//    var address:String!
//    var ownerName:String!
//    var ownerContact:String!
//    var city:String!
//    var postal:String!
//    var latitude:Float!
//    var longitude:Float!
//    
    private let persistentContainer = NSPersistentContainer(name: "Model")
    var context = NSManagedObjectContext()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        context = persistentContainer.viewContext
        
        reviewText.layer.borderWidth = 2.0
        reviewText.layer.borderColor = Colors.mainGreen.cgColor
        reviewText.layer.cornerRadius = 15
        
        submitBtn.layer.borderWidth = 3.0
        submitBtn.layer.borderColor = Colors.mainGreen.cgColor
        submitBtn.layer.cornerRadius = 15
        
        
        ratingScore.rating = 4
        ratingScore.settings.updateOnTouch = true
        
        FarmName.text = farm.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "unwindSegueToFD"{
            
            let dest = segue.destination as! FarmDetailViewController
           
            
//            let rateScore = ratingScore.rating
//            let rateText = reviewText.text
//            
//            
//            
//            dest.ratingNum += 1
//            dest.ratingTotal += rateScore
//
//            
////            dest.title = title
////            dest.address = address
////            dest.name = name
////
////            //            dest.ownerName = farm.owner?.name
////            //            dest.ownerContact = farm.owner?.phone
////            dest.city = city
////            dest.postal = postal
////            dest.latitude = latitude
////            dest.longitude = longitude
////            
//            dest.reviewArray.append(rateText!)
            
            //saveRatingData()
            
//            let tempreview:Review = NSEntityDescription.insertNewObject(forEntityName: "Review", into: context) as! Review
//            tempreview.setValue(reviewText.text, forKey: "content")
//            tempreview.setValue(ratingScore.rating, forKey: "star")
//            tempreview.setValue(farm.name!, forKey: "target")
//            tempreview.setValue(, forKey: "user")
//            
            print(dest.ratingNum)
            dest.reviewTextArray.append(reviewText.text)
            dest.ratingArray.append(ratingScore.rating)
            dest.ratingTotal += ratingScore.rating
            dest.ratingNum += 1
            
            print("|||||||||||||||||||||")
            print(dest.reviewTextArray)
            print(dest.ratingArray)
            print(dest.ratingTotal)
            print(dest.ratingNum)
            
//
//            print(tempreview)
//            print("check!!!!!!!!!!!!!!!!!!!!!!!!!")
//            print(dest.reviewArray)
            


        }
    }
    
    
    func saveRatingData() {
        
        let farmfetchRequest = NSFetchRequest<Farm>(entityName: "Farm")
//        farmfetchRequest.predicate = NSPredicate(format: "name = %@", farm.name!)

        let userfetchRequest = NSFetchRequest<User>(entityName: "User")
//        userfetchRequest.predicate = NSPredicate(format: "name = %@", "Yihan")
        
        print("test1")
        print(farmfetchRequest)
        print(userfetchRequest)
//        print(farmfetchRequest.predicate)
//        print(userfetchRequest.predicate)
        
        do{
            let tempreview:Review = NSEntityDescription.insertNewObject(forEntityName: "Review", into: context) as! Review
            tempreview.setValue(reviewText.text, forKey: "content")
            tempreview.setValue(ratingScore.rating, forKey: "star")
            
//            tempreview.setValue(farmfetchRequest, forKey: "Farm")
//            tempreview.setValue(userfetchRequest, forKey: "User")
            
            
            let farmResults = try context.fetch(farmfetchRequest)
            
            print(farmResults)
            
            print("test2")
            
            if farmResults.count != 0{
                
                print("test3")
                
                let tempFarm = farmResults[0] as! Farm

                farm = tempFarm
                tempFarm.addToReviews(tempreview)
                
                
                
            }
            
            print("check1")
            
            let userResults = try context.fetch(userfetchRequest)
            if userResults.count != 0{
                
                print("test4")
                let tempUser = userResults[0] as! Farm
                tempUser.addToReviews(tempreview)
                
                
            }
            
            
            
            print("check2")
            
            do{
                try context.save()
                
                print("test5")
                
            }catch{
                print("There was an error saving context")
            }
            

        } catch {
            fatalError("Failed to fetch employees: \(error)")
        }

        
        
        
        
        
        

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
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
