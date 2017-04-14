//
//  MapViewController.swift
//  FreshareApp
//
//  Created by Labuser on 3/20/17.
//  Copyright © 2017 ZhuangYihan. All rights reserved.
//
import UIKit
import GoogleMaps
import GooglePlaces


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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //CoreDataManager1.storeFarm(address:"300 Bear's Den Doulevard", city:"St. Louis", latitude : 38.644327 , longitude:-90.313625, name: "S40 Sweat Farm", postal: "63110")
        
        // CoreDataManager1.storeFarm(address:"30 Sheplert's Drive", city:"St. Louis", latitude : 38.645278 , longitude:-90.309892, name: "Clocktower Community Farm", postal: "63120")
        
         //CoreDataManager1.storeFarm(address:"6600 Wash Ave", city:"St. Louis", latitude : 38.652953 , longitude:-90.300472, name: "Greenway Greens", postal: "63130")
        
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
        let farms = CoreDataManager1.fetchFarm()
        for farm in farms {
            let farmMarker = GMSMarker()
            farmMarker.position = CLLocationCoordinate2D(latitude: Double(farm.farmLatitude!), longitude: Double(farm.farmLongitude!)) //Todo optional check
            farmMarker.title = farm.farmName
            farmMarker.snippet = farm.farmCity
            farmMarker.icon = GMSMarker.markerImage(with: UIColor.green)
            //farmMaker.iconView = UIImage("Image!!!")
            //print(farm.farmName)
            //print(farm.farmLatitude)
            //print(farm.farmLongitude)
            farmMarker.map = mapView
            
        }
        
    }
    
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
     print(marker.title!)
        print("tapped")
        
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
    
    
}
