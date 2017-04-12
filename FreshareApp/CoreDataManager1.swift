//
//  CoreDataManager1.swift
//  FreshareApp
//
//  Created by Angelica Tao on 4/9/17.
//  Copyright © 2017 ZhuangYihan. All rights reserved.
//

import UIKit
import CoreData

struct farmItem {
    var farmAddress:String?
    var farmCity:String?
    var farmLatitude:Float?
    var farmLongitude:Float?
    var farmName:String?
    var farmPostal:String?
    
    init() {
        farmAddress = ""
        farmCity = ""
        farmLatitude = 0
        farmLongitude = 0
        farmName = ""
        farmPostal = ""
    }
    
    init(address:String,city:String,latitude:Float,longitude:Float,name:String,postal:String) {
        self.farmAddress = address
        self.farmCity = city
        self.farmLatitude = latitude
        self.farmLongitude = longitude
        self.farmName = name
        self.farmPostal = postal
    }
}

@available(iOS 10.0, *)
class CoreDataManager1: NSObject {
    private class func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    
    
    // syntax for using the function:
    //      CoreDataManager1.storeFarm(address:"farm1", city:"stl", ......, postal:"12345")
    class func storeFarm(address:String, city:String, latitude:Float, longitude:Float, name:String, postal:String) {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Farm", in: context)
        let managedObject = NSManagedObject(entity: entity!, insertInto: context)
        managedObject.setValue(address, forKey: "address")
        managedObject.setValue(city, forKey: "city")
        managedObject.setValue(latitude, forKey: "latitude")
        managedObject.setValue(longitude, forKey: "longitude")
        managedObject.setValue(name, forKey: "name")
        managedObject.setValue(postal, forKey: "postal")
        
        do {
            try context.save()
            print("Farm saved!")
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    class func storeProduce(name:String, price:Double) {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Produce", in: context)
        let managedObject = NSManagedObject(entity: entity!, insertInto: context)
        managedObject.setValue(name, forKey: "name")
        managedObject.setValue(price, forKey: "price")
        
        do {
            try context.save()
            print("Produce saved!")
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    class func storeReview(content:String, star:Int16) {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Review", in: context)
        let managedObject = NSManagedObject(entity: entity!, insertInto: context)
        managedObject.setValue(content, forKey: "content")
        managedObject.setValue(star, forKey: "star")
        
        do {
            try context.save()
            print("Review saved!")
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    class func storeUser(email:String, name:String, phone:String) {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "User", in: context)
        let managedObject = NSManagedObject(entity: entity!, insertInto: context)
        managedObject.setValue(email, forKey: "email")
        managedObject.setValue(name, forKey: "name")
        managedObject.setValue(phone, forKey: "phone")
        
        do {
            try context.save()
            print("User created!")
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    
    // fetch Farm objects from core data based on predicate
    // syntax: CoreDataManager1.fetchFarm()
    class func fetchFarm(selectedScopeIdx:Int?=nil, targetText:String?=nil) -> [farmItem] {
        var array = [farmItem]()
        
        let fetchRequest:NSFetchRequest<Farm> = Farm.fetchRequest()
        
//        var predicate = NSPredicate(format: "name contains[c] %@", "001")
//        predicate = NSPredicate(format: "by == %@ AND year > %@", "wang")
//        predicate = NSPredicate(format: "year > %@", "2012")
//        fetchRequest.predicate = predicate
        
        
        if selectedScopeIdx != nil && targetText != nil{
            
            var filterKeyword = ""
            switch selectedScopeIdx! {
            case 0:
                filterKeyword = "address"
            case 1:
                filterKeyword = "city"
            case 2:
                filterKeyword = "latitude"
            case 3:
                filterKeyword = "longitude"
            case 4:
                filterKeyword = "name"
            default:
                filterKeyword = "postal"
            }
            
            var predicate = NSPredicate(format: "\(filterKeyword) contains[c] %@", targetText!)
            //predicate = NSPredicate(format: "by == %@" , "wang")
            //predicate = NSPredicate(format: "year > %@", "2015")
            
            fetchRequest.predicate = predicate
        }
        
        do {
            let fetchResult = try getContext().fetch(fetchRequest)
            
            for item in fetchResult {
                let farm = farmItem(address:item.address!, city:item.city!, latitude:item.latitude, longitude:item.longitude, name:item.name!, postal:item.postal!)
                array.append(farm)
                print(farm.farmName!+"\n")
            }
        }
        catch {
            print(error.localizedDescription)
        }
        
        return array
    }
    
    // delete farms in core data based on predicate
    // syntax: CoreDataManager1.cleanCoreDataFarm()
    class func cleanCoreDataFarm() {
        let fetchRequest:NSFetchRequest<Farm> = Farm.fetchRequest()
        
//        var predicate = NSPredicate(format: "name contains[c] %@", "001")
//        fetchRequest.predicate = predicate
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
        
        do {
            print("deleting contents")
            try getContext().execute(deleteRequest)
        } catch {
            print(error.localizedDescription)
        }
    }
}

