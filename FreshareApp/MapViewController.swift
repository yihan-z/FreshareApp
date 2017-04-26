//
//  MapViewController.swift
//  FreshareApp
//
//  Created by Labuser on 3/20/17.
//  Copyright © 2017 Eric Chao. All rights reserved.
//
import UIKit
import GoogleMaps
import GooglePlaces
import CoreData

@available(iOS 10.0, *)
class MapViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {
    
    @IBOutlet var mapView: GMSMapView!
    var locationManager = CLLocationManager()
    var didFindMyLocation = false
    var currentLocation: CLLocation?
    //var mapView: GMSMapView!
    var placesClient: GMSPlacesClient!
    var zoomLevel: Float = 15.0
    var longitude : Double = -90.301656
    var latitude : Double = 38.648930
    
    
    //var curFarm : farmItem? = nil
    //var farmArray = [Farm]()

    var curFarm:Farm!
    
    private let persistentContainer = NSPersistentContainer(name: "Model")
    fileprivate lazy var fetchedFarmsController: NSFetchedResultsController<Farm> = {
        
        let fetchRequest: NSFetchRequest<Farm> = Farm.fetchRequest()
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        
        // Configure Fetched Results Controller
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        //let farms = CoreDataManager1.fetchFarm()
        
        persistentContainer.loadPersistentStores { (persistentStoreDescription, error) in
            if let error = error {
                print("Unable to Load Persistent Store")
                print("\(error), \(error.localizedDescription)")
                
            } else {
                
                do {
                    try self.fetchedFarmsController.performFetch()
                    print("******performing fetch ...")
                } catch {
                    let fetchError = error as NSError
                    print("Unable to Perform Fetch Request")
                    print("\(fetchError), \(fetchError.localizedDescription)")
                }
                
            }

        }
        
        //Find current position
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 50
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    
        if(CLLocationManager.authorizationStatus()==CLAuthorizationStatus.authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
            currentLocation = locationManager.location
        }
        if(CLLocationManager.authorizationStatus() == CLAuthorizationStatus.notDetermined){
            print("Error in finding location, did you deny access?")
            //exit()
        }
        //Default location (without authorization access) is STL
        
        if currentLocation != nil { //TODO Reset
            print("not nil")
            longitude = currentLocation!.coordinate.longitude
            latitude = currentLocation!.coordinate.latitude
        } else { // STL
            longitude = -90.301656
            latitude = 38.648930
        }
        
        let camera: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude,  zoom: zoomLevel)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.delegate = self
        self.mapView.delegate = self
        view = mapView
        view.addObserver(self, forKeyPath: "myLocation", options: NSKeyValueObservingOptions.new, context: nil)
        
        
        
        // Creates a marker in the center of the map where you are
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        marker.title = "Your Location"
        marker.snippet = NSLocale.current.regionCode
        marker.map = mapView
        
        //Load all farms

        let farms = fetchedFarmsController.fetchedObjects! as [Farm]
        
        print("**********\(farms.count)")
        
        for farm in farms {
            let farmMarker = GMSMarker()
            farmMarker.position = CLLocationCoordinate2D(latitude: Double(farm.latitude), longitude: Double(farm.longitude)) //Todo optional check
            farmMarker.title = farm.name
            farmMarker.snippet = farm.city
            farmMarker.icon = GMSMarker.markerImage(with: UIColor.green)
            farmMarker.userData = farm
            //farmMarker.icon = UIImage(farm.image)
            //farmMarker.icon = UIImage(named: farm.image!)
            //farmMaker.iconView = UIImage("Image!!!")
    
            farmMarker.map = mapView
            
        }
    }
    
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
     print(marker.title!)
        
        curFarm = marker.userData as! Farm?
        print("tapped")
        performSegue(withIdentifier: "MaptoFarm", sender: nil)
        //Place link to new farmdetailviewcontroller
        self.mapView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.authorizedWhenInUse {
            mapView.isMyLocationEnabled = true
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MaptoFarm"{
            
            let dest = segue.destination as! FarmDetailViewController
        
            
            let farm = curFarm
            
//            dest.title = farm?.farmName
//            dest.address = farm?.farmAddress
//            //            dest.ownerName = farm.owner?.name
//            //            dest.ownerContact = farm.owner?.phone
//            dest.city = farm?.farmCity
//            dest.postal = farm?.farmPostal
//            dest.latitude = farm?.farmLatitude
//            dest.longitude = farm?.farmLongitude
  
//            dest.clickedFarm = farm
            dest.clickedFarm = farm
//            dest.title = farm?.farmName
//            dest.address = farm?.farmAddress
//            //            dest.ownerName = farm.owner?.name
//            //            dest.ownerContact = farm.owner?.phone
//            dest.city = farm?.farmCity
//            dest.postal = farm?.farmPostal
//            dest.latitude = farm?.farmLatitude
//            dest.longitude = farm?.farmLongitude
//            
        }
    }

   func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        
        print(2)
        let infoWindow = Bundle.main.loadNibNamed("CustomInfoWindow", owner: self.view, options: nil)!.first! as! CustomInfoWindow
        print(1)
        infoWindow.label.text = "\(marker.position.latitude) \(marker.position.longitude)"
        infoWindow.label.text = marker.title
        infoWindow.layer.cornerRadius = 10.0
        let farmInfo : Farm = marker.userData as! Farm
        infoWindow.label2.text = farmInfo.address
        infoWindow.imageView.image = UIImage(named: farmInfo.image!)
        return infoWindow
    }
 
    
}

@available(iOS 10.0, *)
extension MapViewController: NSFetchedResultsControllerDelegate {}

