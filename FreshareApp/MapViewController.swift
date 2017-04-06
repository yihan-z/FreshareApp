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


class MapViewController: UIViewController, CLLocationManagerDelegate {
    
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
        
        
        
        //Find current position
        locationManager = CLLocationManager()
<<<<<<< HEAD
=======
      
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
       
>>>>>>> origin/master
        
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
        view = mapView
        
        view.addObserver(self, forKeyPath: "myLocation", options: NSKeyValueObservingOptions.new, context: nil)
        
        
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        marker.title = "Your Location"
        marker.snippet = NSLocale.current.regionCode
        marker.map = mapView
        
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
