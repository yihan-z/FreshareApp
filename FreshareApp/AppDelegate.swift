//
//  AppDelegate.swift
//  FreshareApp
//
//  Created by ZhuangYihan on 3/6/17.
//  Copyright © 2017 ZhuangYihan. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import GoogleMaps
import GooglePlaces

@available(iOS 10.0, *)
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    
    var window: UIWindow?
    var signedIn:Bool = false
    
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Freshare")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FIRApp.configure()
        
        // Initialize sign-in
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(configureError)")
        
        GIDSignIn.sharedInstance().delegate = self
        
        
        GMSServices.provideAPIKey("AIzaSyB71aFioGQv5AZmYmRSvjqsXr3x1Jp1lHQ")
        GMSPlacesClient.provideAPIKey("AIzaSyB71aFioGQv5AZmYmRSvjqsXr3x1Jp1lHQ")
        
        // Check CoreData setup
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        print("*****\(context)*****")
        
        let checkFetch = NSFetchRequest<Farm>(entityName: "Farm")
        
        do {
            let fetchedFarms = try context.fetch(checkFetch as! NSFetchRequest<Farm> )
            print("found \(fetchedFarms.count)")
            if(fetchedFarms.count == 0) {
                print("*****populating database******")
                let uNames = ["Angelica","Eric","Shuya"]
                let uEmails = ["angelica@freshare.com", "eric@freshare.com", "shuya@freshare.com"]
                let uPhones = ["3144359876", "3144358765", "3144357654"]
                
                let eric = NSEntityDescription.insertNewObject(forEntityName: "User", into: context)
                eric.setValue(uNames[0], forKey: "name")
                eric.setValue(uEmails[0], forKey: "email")
                eric.setValue(uPhones[0], forKey: "phone")
                
                let angelica = NSEntityDescription.insertNewObject(forEntityName: "User", into: context)
                angelica.setValue(uNames[1], forKey: "name")
                angelica.setValue(uEmails[1], forKey: "email")
                angelica.setValue(uPhones[1], forKey: "phone")

                let shuya = NSEntityDescription.insertNewObject(forEntityName: "User", into: context)
                shuya.setValue(uNames[2], forKey: "name")
                shuya.setValue(uEmails[2], forKey: "email")
                shuya.setValue(uPhones[2], forKey: "phone")
                
                do {
                    try context.save()
                    print("created users")
                } catch {
                    print("There was an error creating users")
                }
                
                let fNames = ["Angelica's Farm","Eric's Ranch","Shuya's Orchard"]
                let fAddress = ["Fake Address 1", "Fake Address 2", "Fake Address 3"]
                let fCities = ["St. Louis", "St. Louis", "St. Louis"]
                let fLats = [48, 48, 48] // please make them make sense
                let fLongs = [-90, -90, -90] // replace with sensible longitudes
                let fPosts = ["63110", "63112", "63130"]
                
                let efarm = NSEntityDescription.insertNewObject(forEntityName: "Farm", into: context)
                efarm.setValue(fNames[0], forKey: "name")
                efarm.setValue(fAddress[0], forKey: "address")
                efarm.setValue(fCities[0], forKey: "city")
                efarm.setValue(fLats[0], forKey: "latitude")
                efarm.setValue(fLongs[0], forKey: "longitude")
                efarm.setValue(fPosts[0], forKey: "postal")
                efarm.setValue(eric, forKey: "owner")
                
                let afarm = NSEntityDescription.insertNewObject(forEntityName: "Farm", into: context)
                afarm.setValue(fNames[1], forKey: "name")
                afarm.setValue(fAddress[1], forKey: "address")
                afarm.setValue(fCities[1], forKey: "city")
                afarm.setValue(fLats[1], forKey: "latitude")
                afarm.setValue(fLongs[1], forKey: "longitude")
                afarm.setValue(fPosts[1], forKey: "postal")
                afarm.setValue(angelica, forKey: "owner")
                
                let sfarm = NSEntityDescription.insertNewObject(forEntityName: "Farm", into: context)
                sfarm.setValue(fNames[2], forKey: "name")
                sfarm.setValue(fAddress[2], forKey: "address")
                sfarm.setValue(fCities[2], forKey: "city")
                sfarm.setValue(fLats[2], forKey: "latitude")
                sfarm.setValue(fLongs[2], forKey: "longitude")
                sfarm.setValue(fPosts[2], forKey: "postal")
                sfarm.setValue(shuya, forKey: "owner")

                do {
                    try context.save()
                    print("created farms")
                } catch {
                    print("There was an error creating farms")
                }
                
                let prodNames = ["tomato","lettuce","potato"]
                let prodPrices = [1.5, 1.6, 1.7]
                
                let tomato = NSEntityDescription.insertNewObject(forEntityName: "Produce", into: context)
                tomato.setValue(prodNames[0], forKey: "name")
                tomato.setValue(prodPrices[0], forKey: "price")
                tomato.setValue(efarm, forKey: "farm")

                let lettuce = NSEntityDescription.insertNewObject(forEntityName: "Produce", into: context)
                lettuce.setValue(prodNames[1], forKey: "name")
                lettuce.setValue(prodPrices[1], forKey: "price")
                lettuce.setValue(afarm, forKey: "farm")

                let potato = NSEntityDescription.insertNewObject(forEntityName: "Produce", into: context)
                potato.setValue(prodNames[2], forKey: "name")
                potato.setValue(prodPrices[2], forKey: "price")
                potato.setValue(sfarm, forKey: "farm")

                do {
                    try context.save()
                    print("created produce")
                } catch {
                    print("There was an error creating produce")
                }
                
                let rContents = ["Love Eric's tomatoes","Love Angelica's lettuce!"]
                let rStars = [5, 5]

                let sereview = NSEntityDescription.insertNewObject(forEntityName: "Review", into: context)
                sereview.setValue(rContents[0], forKey: "content")
                sereview.setValue(rStars[0], forKey: "star")
                sereview.setValue(shuya, forKey: "user")
                sereview.setValue(efarm, forKey: "target")
                
                let sareview = NSEntityDescription.insertNewObject(forEntityName: "Review", into: context)
                sareview.setValue(rContents[1], forKey: "content")
                sareview.setValue(rStars[1], forKey: "star")
                sareview.setValue(shuya, forKey: "user")
                sareview.setValue(afarm, forKey: "target")

                do {
                    try context.save()
                    print("created reviews")
                } catch {
                    print("There was an error creating reviews")
                }
            }
        } catch {
            fatalError("Failed to fetch employees: \(error)")
        }
        
        
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ application: UIApplication,
                     open url: URL, options: [UIApplicationOpenURLOptionsKey: Any]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url,
                                                 sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                 annotation: options[UIApplicationOpenURLOptionsKey.annotation])
    }

    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: NSError!) {
        if (error == nil) {
            // Perform any operations on signed in user here.
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            if user.profile.hasImage {
                let pic = user.profile.imageURL(withDimension: 64)
            }
            signedIn = true
        } else {
            print("\(error.localizedDescription)")
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user:GIDGoogleUser!,
              withError error: NSError!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
}
