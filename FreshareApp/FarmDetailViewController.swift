//
//  FarmViewController.swift
//  FreshareApp
//
//  Created by ZhuangYihan on 3/7/17.
//  Copyright © 2017 ZhuangYihan. All rights reserved.
//

import UIKit
import MapKit

@available(iOS 10.0, *)
class FarmDetailViewController: UIViewController {
    
    
//    struct cellData{
//        let cell: Int!
//        let reviewtext: String!
//    }
    
    @IBOutlet weak var ProduceReviewSegment: UISegmentedControl!
    @IBOutlet weak var contactBtn: UIButton!
    
    @IBOutlet weak var farmName: UILabel!
    @IBOutlet weak var farmOwnerName: UILabel!
    @IBOutlet weak var farmAddress: UILabel!
    @IBOutlet weak var farmCityPost: UILabel!
    
    
//    @IBOutlet weak var distanceLabel: UILabel!
//    @IBOutlet weak var etaLabel: UILabel!

    @IBOutlet weak var mapBtn: UIButton!
    @IBOutlet weak var cosmosView: CosmosView!
    @IBOutlet weak var rateBtn: UIButton!
    
   
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var userView: UIImageView!
    
    
    @IBAction func listChanged(_ sender: Any) {
        
        switch ProduceReviewSegment.selectedSegmentIndex
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
    
    
    @IBAction func contactFarmer(_ sender: Any) {
         callNumber(phoneNumber: (clickedFarm.owner?.phone)!)
    }
    
    @IBAction func unwindToFD(segue: UIStoryboardSegue){
        
    }
    
    // TO CONNECT WITH STORYBOARD ITEMS
    var clickedFarm:Farm!
    
    var name:String!
    var address:String!
    var ownerName:String!
    var ownerContact:String!
    var city:String!
    var postal:String!
    var latitude:Float!
    var longitude:Float!
    var imageTitle:String!
    var userImageTitle:String!
    
    var selflat : Double = 48.648930
    var selflng : Double = -90.301656
    
    var sourcePlacemark:MKPlacemark!
    var sourceMapItem:MKMapItem!
    var destPlacemark:MKPlacemark!
    var destMapItem:MKMapItem!
    
    var ratingNum:Double = 0
    var ratingTotal: Double = 0
    
    var reviewArray = [Review]()
    var reviewTextArray = [String]()
    var ratingArray = [Double]()
    
    var produceArray = [Produce]()
    
    var segmentIndex:Int! = 0
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        
        contactBtn.layer.borderWidth = 3.0
        contactBtn.layer.borderColor = Colors.mainGreen.cgColor
        contactBtn.layer.cornerRadius = 12
        
        mapBtn.layer.borderWidth = 3.0
        mapBtn.layer.borderColor = Colors.mainGreen.cgColor
        mapBtn.layer.cornerRadius = 12

        
        rateBtn.layer.borderWidth = 3.0
        rateBtn.layer.borderColor = Colors.mainGreen.cgColor
        rateBtn.layer.cornerRadius = 12

//        userView.frame = CGRect(x: 0, y: 0, width: 50, height: 25)
        
        
//        imageView = UIImageView(frame: CGRectMake(5, 5, 50, 50))
        //imageView.frame = CGRect(x: 40, y: 40, width: 40, height: 40);
        imageView.layer.borderWidth = 3.0
        imageView.layer.borderColor = Colors.mainGreen.cgColor
        imageView.clipsToBounds = true
        

        userView.layer.cornerRadius = userView.frame.size.width / 2
        userView.clipsToBounds = true
        
        
        
        // Do any additional setup after loading the view.

        name = clickedFarm.name
        ownerName = clickedFarm.owner?.name
        ownerContact = clickedFarm.owner?.phone
        address = clickedFarm.address
        city = clickedFarm.city
        postal = clickedFarm.postal
        latitude = clickedFarm.latitude
        longitude = clickedFarm.longitude
        
        imageTitle = clickedFarm.image
        userImageTitle = clickedFarm.owner?.image
        
        farmName.text = name
        farmOwnerName.text = ownerName
        farmAddress.text = address
        let citypost:String = city! + ", " + postal!
       
        farmCityPost.text = citypost
        
        imageView.image = UIImage(named: imageTitle)
        userView.image = UIImage(named: userImageTitle)
        
        
        // Calculate distance and ETA
        // Get current position
        let selfCoordinates = CLLocationCoordinate2DMake(selflat, selflng)
        sourcePlacemark = MKPlacemark(coordinate: selfCoordinates, addressDictionary: nil)
        sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        
        // Get destination position
        let destinationCoordinates = CLLocationCoordinate2DMake(Double(latitude), Double(longitude))
        destPlacemark = MKPlacemark(coordinate: destinationCoordinates, addressDictionary: nil)
        destMapItem = MKMapItem(placemark: destPlacemark)
        
        //setLabelValues()
        
        produceArray = Array(clickedFarm.produce!) as! [Produce]
        reviewArray = Array(clickedFarm.reviews!) as! [Review]
        
        //ratingNum = Double(reviewArray.count)
        
        for r in reviewArray {
            reviewTextArray.append(r.content!)
            ratingArray.append(r.star)
            ratingTotal += r.star
            ratingNum += 1
        }
        
        

        // set review numbers and sum stars
        cosmosView.rating = ratingTotal / ratingNum
        cosmosView.settings.updateOnTouch = false
        
        //self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.reloadData()
        

        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        imageView.frame = CGRect(x: 40, y: 40, width: 40, height: 40);
//        ratingNum = 0
//        for r in reviewArray {
//            ratingArray.append(r.star)
//            ratingTotal += r.star
//            ratingNum += 1
//        }
//        
//        print("@@@@@@@@@@@@@@@@@@@@@@@@@@@")
//        print(reviewArray)
//        
//        print("ratingArray")
//        print(ratingArray)
//        
//        print(ratingTotal)
//        print(ratingNum)
        
        // set review numbers and sum stars
        cosmosView.rating = ratingTotal / ratingNum
        cosmosView.settings.updateOnTouch = false
        
        //self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func openMapForPlace(_ sender: AnyObject) { // CONNET THIS TO mapBtn
        
        destMapItem.name = "Target location"
        destMapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
    }
    
//    func setLabelValues() {
//        // Create request
//        let request = MKDirectionsRequest()
//        request.source = sourceMapItem
//        request.destination = destMapItem
//        request.transportType = MKDirectionsTransportType.automobile
//        request.requestsAlternateRoutes = false
//        let directions = MKDirections(request: request)
//        directions.calculate { response, error in
//            if let route = response?.routes.first {
//                print("************success")
//                let dist = Utility.convertCLLocationDistanceToMiles(targetDistance: route.distance)
////                let dist = route.distance
//                let eta = route.expectedTravelTime
//                let distLabelText = String(format: "%.1f mi", dist)
//                let hour = Int(eta/3600)
//                let min = Int((eta.truncatingRemainder(dividingBy: 3600))/60)
//                print("Distance: \(distLabelText), ETA: \(hour) h \(min) m")
//                
//                // UNCOMMENT THESE LINES AFTER HOOKING THE STORYBOARD
//                self.distanceLabel.text = distLabelText
//                self.etaLabel.text = "\(hour) h \(min) m"
//                
//            } else {
//                print("Error!")
//                
//            }
//        }
//    }

//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        //        guard let farms = fetchedResultsController.fetchedObjects else { return 0 }
//        //        return farms.count
//        return reviewArray.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        print("******populating table")
//        guard let cell = reviewTableView.dequeueReusableCell(withIdentifier: ReviewTableViewCell.reuseIdentifier, for: indexPath) as? ReviewTableViewCell else {
//            fatalError("Unexpected Index Path")
//        }
//        
//        // Fetch Quote
//        //        let farm = fetchedResultsController.object(at: indexPath)
//        let reviewText = reviewArray[indexPath.row]
//        
//        // Configure Cell
//        
//        print("fetching indexPath \(indexPath.row)")
//        print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
//        print("review: \(reviewText)")
//        cell.review.text = reviewText
//        
//        return cell
//    }
//    
    
    
    
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.reviewArray.count;
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell") as! UITableViewCell
//        
//        cell.textLabel?.text = self.reviewArray[indexPath.row]
//        
//        return cell
//    }
//    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        print("You selected cell #\(indexPath.row)!")
//    }
//    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToRatingSegue"{
            
            let dest = segue.destination as! RateViewController
            
            dest.farm = clickedFarm
            
            print("clickedFarm_review")
            print(clickedFarm.reviews)
            
//            dest.title = title
//            dest.address = address
//            dest.name = name
//
//            //            dest.ownerName = farm.owner?.name
//            //            dest.ownerContact = farm.owner?.phone
//            dest.city = city
//            dest.postal = postal
//            dest.latitude = latitude
//            dest.longitude = longitude
        }
    }
    
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    
    private func callNumber(phoneNumber:String) {
        if let phoneCallURL:NSURL = NSURL(string:"tel://\(phoneNumber)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL as URL)) {
                application.openURL(phoneCallURL as URL);
            }
        }
    }
    
}


@available(iOS 10.0, *)
extension FarmDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (segmentIndex == 0){ // produce list
            return produceArray.count
        }
        else if (segmentIndex == 1){
            print("??????????????????????????????????")
            return reviewTextArray.count
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell") as! ReviewTableViewCell
        
        if (segmentIndex == 0){ // produce list
            let produce = produceArray[indexPath.row]

            print("fetching indexPath \(indexPath.row)")
            print("review \(produce.name)")
            // Configure Cell
            cell.review.text = produce.name
            cell.user_ratings.isHidden = true
//            cell.user_ratings.settings.updateOnTouch = false
        }
        else { // review list

            let review = reviewTextArray[indexPath.row]
            let ratingScore = ratingArray[indexPath.row]
            
            //print(ratingScore)

            // Configure Cell
            cell.review.text = review
            cell.user_ratings.isHidden = false

            cell.user_ratings.rating = ratingScore
            cell.user_ratings.settings.updateOnTouch = false
        }

        return cell
    }
    
    
}
