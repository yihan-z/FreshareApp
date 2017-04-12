//
//  SearchViewController.swift
//  FreshareApp
//
//  Created by ZhuangYihan on 3/7/17.
//  Copyright © 2017 ZhuangYihan. All rights reserved.
//

import UIKit
import CoreData

@available(iOS 10.0, *)
class SearchViewController: UIViewController, UISearchBarDelegate {
    
    fileprivate var farmArray = [farmItem]()
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var category: UISegmentedControl!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    
    
    // setup CoreData fetch control for Farm object
    private let persistentContainer = NSPersistentContainer(name: "Freshare")
    fileprivate lazy var fetchedResultsController: NSFetchedResultsController<Farm> = {

        let fetchRequest: NSFetchRequest<Farm> = Farm.fetchRequest()
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        
        // Configure Fetched Results Controller
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        persistentContainer.loadPersistentStores { (persistentStoreDescription, error) in
            if let error = error {
                print("Unable to Load Persistent Store")
                print("\(error), \(error.localizedDescription)")
                
            } else {
                self.setupView()
                
                do {
                    try self.fetchedResultsController.performFetch()
                } catch {
                    let fetchError = error as NSError
                    print("Unable to Perform Fetch Request")
                    print("\(fetchError), \(fetchError.localizedDescription)")
                }
                
                self.updateView()
            }
        }
        self.searchBar.delegate = self
//        presetCoreData() // unless core data is deleted, don't invoke again
        farmArray = CoreDataManager1.fetchFarm()
        setupView()
    }
    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        print("search detected")
//        guard !searchText.isEmpty else {
//            
//            
//            if category.selectedSegmentIndex == 0 {
//                farmArray = CoreDataManager1.fetchFarm()
//                tableView.reloadData()
//                print("data reload")
//                return
//            }
//            else {
//                // list by produce - not sure how it would be different 
//                //    than farms at this point
//                return
//            }
//        }
//        
//        if category.selectedSegmentIndex == 0 { // by farm
//            farmArray = CoreDataManager1.fetchFarm(selectedScopeIdx: 4, targetText:searchText)
//            print(searchText)
//            tableView.reloadData()
//            print("data reload")
//            print(searchText)
//        }
//        else { // search by produce
//            
//        }
//        
//    }
    
    func presetCoreData() {
        CoreDataManager1.storeFarm(address: "6985 Snow Way Dr", city: "St. Louis", latitude: 38.650544, longitude: -90.313655, name: "village farm", postal: "63130")
        CoreDataManager1.storeFarm(address: "6515 Wydown Blvd", city: "St. Louis", latitude: 38.644575, longitude: -90.312156, name: "S40 farm", postal: "63105")
        CoreDataManager1.storeFarm(address: "fake address 1", city: "St. Louis", latitude: -38, longitude: -90, name: "fake farm 001", postal: "63130")
        CoreDataManager1.storeFarm(address: "fake address 2", city: "St. Louis", latitude: -39, longitude: -90.3, name: "fake farm 002", postal: "63130")

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateData() {
        farmArray = CoreDataManager1.fetchFarm()
    }
    
    private func updateView() {
        var hasFarms = false
        
        if let farms = fetchedResultsController.fetchedObjects {
            hasFarms = farms.count > 0
        }
        
        tableView.isHidden = !hasFarms
        messageLabel.isHidden = hasFarms
        
        activityIndicatorView.stopAnimating()
    }
    private func setupView() {
        setupMessageLabel()
//        setUpSearchBar()

        updateView()
    }
    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        
//        guard !searchText.isEmpty else {
//            farmArray = CoreDataManager1.fetchFarm()
//            tableView.reloadData()
//            return
//        }
//        
//        if category.selectedSegmentIndex == 0 {
//            farmArray = CoreDataManager1.fetchFarm(selectedScopeIdx: 4, targetText:searchText)
//            tableView.reloadData()
//            print(searchText)
//        }
//        else {
//            
//        }
//    }

    
    // MARK: -
    
    private func setupMessageLabel() {
        messageLabel.text = "There is nothing to display."
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FarmDetailSegue"{
            
            let dest = segue.destination as! FarmDetailViewController
            let index = tableView.indexPathForSelectedRow
            
            let farm = farmArray[index!.row]
            
            dest.title = farm.farmName
            dest.address = farm.farmAddress
//            dest.ownerName = farm.owner?.name
//            dest.ownerContact = farm.owner?.phone
            dest.city = farm.farmCity
            dest.postal = farm.farmPostal
            dest.latitude = farm.farmLatitude
            dest.longitude = farm.farmLongitude
        }
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("search detected")
        guard !searchText.isEmpty else {
            
            
            if category.selectedSegmentIndex == 0 {
                farmArray = CoreDataManager1.fetchFarm()
                tableView.reloadData()
                print("data reload")
                return
            }
            else {
                // list by produce - not sure how it would be different
                //    than farms at this point
                return
            }
        }
        
        if category.selectedSegmentIndex == 0 { // by farm
            farmArray = CoreDataManager1.fetchFarm(selectedScopeIdx: 4, targetText:searchText)
            print(searchText)
            tableView.reloadData()
            print("data reload")
            print(searchText)
        }
        else { // search by produce
            
        }
        
    }

    
}

@available(iOS 10.0, *)
extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        guard let farms = fetchedResultsController.fetchedObjects else { return 0 }
//        return farms.count
        return farmArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("******populating table")
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.reuseIdentifier, for: indexPath) as? SearchTableViewCell else {
            fatalError("Unexpected Index Path")
        }
        
        // Fetch Quote
//        let farm = fetchedResultsController.object(at: indexPath)
        let farm = farmArray[indexPath.row]
        print("fetching indexPath \(indexPath.row)")
        print("farm has name \(farm.farmName)")
        // Configure Cell
        cell.nameLabel.text = farm.farmName
        cell.detailLabel.text = farm.farmPostal
        
        return cell
    }

    
}

@available(iOS 10.0, *)
extension SearchViewController: NSFetchedResultsControllerDelegate {}
