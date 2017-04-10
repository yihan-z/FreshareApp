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
        
        setupView()
    }
    
    fileprivate func setUpSearchBar() {
        let searchBar = UISearchBar(frame: CGRect(x:0, y:0, width:self.view.bounds.width, height: 65))
        searchBar.showsScopeBar = true
        searchBar.scopeButtonTitles = ["Farm Name", "Produce"]
        searchBar.selectedScopeButtonIndex = 0
        
        searchBar.delegate = self
        
        self.tableView.tableHeaderView = searchBar
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard !searchText.isEmpty else {
            
            
            if searchBar.selectedScopeButtonIndex == 0 {
                farmArray = CoreDataManager1.fetchFarm()
                tableView.reloadData()
                return
            }
            else {
                
                return
            }
        }
        
        if searchBar.selectedScopeButtonIndex == 0 {
            farmArray = CoreDataManager1.fetchFarm(selectedScopeIdx: 0, targetText:searchText)
            tableView.reloadData()
            print(searchText)
        }
        else {
            
        }
        
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
        
        updateView()
    }
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! TableViewCell
//        
//        let farmItem = farmArray[indexPath.row]
//        
//        cell.imgView.image = UIImage(named:imgItem.imageName!)
//        cell.nameLabel.text = imgItem.imageName!
//        cell.byLabel.text = imgItem.imageBy!
//        cell.yearLabel.text = imgItem.imageYear!
//        
//        return cell
//    }
    
    // MARK: -
    
    private func setupMessageLabel() {
        messageLabel.text = "There is nothing to display."
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FarmDetailSegue"{
            
            let dest = segue.destination as! FarmDetailViewController
            let index = tableView.indexPathForSelectedRow
            
            let farm = fetchedResultsController.object(at: index!)
            
            dest.title = farm.name
            dest.address = farm.address
            dest.ownerName = farm.owner?.name
            dest.ownerContact = farm.owner?.phone
            dest.city = farm.city
            dest.postal = farm.postal
            dest.latitude = farm.latitude
            dest.longitude = farm.longitude
        }
    }
    
    
}

@available(iOS 10.0, *)
extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let farms = fetchedResultsController.fetchedObjects else { return 0 }
        return farms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("******populating table")
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.reuseIdentifier, for: indexPath) as? SearchTableViewCell else {
            fatalError("Unexpected Index Path")
        }
        
        // Fetch Quote
        let farm = fetchedResultsController.object(at: indexPath)
        print("fetching indexPath \(indexPath.row)")
        print("farm has name \(farm.name)")
        // Configure Cell
        cell.nameLabel.text = farm.name
        cell.detailLabel.text = farm.postal
        
        return cell
    }

    
}

@available(iOS 10.0, *)
extension SearchViewController: NSFetchedResultsControllerDelegate {}
