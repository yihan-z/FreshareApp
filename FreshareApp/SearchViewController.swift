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
    
    
    //fileprivate var farmArray = [farmItem]()
    var farmArray = [Farm]()
    var produceArray = [Produce]()
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var category: UISegmentedControl!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    
    
    // setup CoreData fetch control for Farm object
    private let persistentContainer = NSPersistentContainer(name: "Model")
    fileprivate lazy var fetchedFarmsController: NSFetchedResultsController<Farm> = {
        
        let fetchRequest: NSFetchRequest<Farm> = Farm.fetchRequest()
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        
        // Configure Fetched Results Controller
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()
    
    fileprivate lazy var fetchedProduceController: NSFetchedResultsController<Produce> = {
        
        let fetchRequest: NSFetchRequest<Produce> = Produce.fetchRequest()
        
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
                    try self.fetchedFarmsController.performFetch()
                    try self.fetchedProduceController.performFetch()
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
        //farmArray = CoreDataManager1.fetchFarm()
        
        farmArray = fetchedFarmsController.fetchedObjects!
        produceArray = fetchedProduceController.fetchedObjects!
        
        setupView()
    }
    
//    func presetCoreData() {

//        
//    }
//    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateData() {
        //farmArray = CoreDataManager1.fetchFarm()
        farmArray = fetchedFarmsController.fetchedObjects!
        produceArray = fetchedProduceController.fetchedObjects!
    }
    
    private func updateView() {
        let hasFarms = true
        
        tableView.isHidden = !hasFarms
        messageLabel.isHidden = hasFarms
        
        activityIndicatorView.stopAnimating()
    }
    private func setupView() {
        setupMessageLabel()
        //        setUpSearchBar()
        
        updateView()
    }
    
    // MARK: -
    
    private func setupMessageLabel() {
        messageLabel.text = "There is nothing to display."
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FarmDetailSegue"{
            
            let dest = segue.destination as! FarmDetailViewController
            let index = tableView.indexPathForSelectedRow
            
            if category.selectedSegmentIndex == 0 {
                // IF (FARM SEGMENT)
                let farm = farmArray[index!.row]
                dest.clickedFarm = farm
            }
            else {
                
                // IF (PRODUCE SEGMENT)
                let produce = produceArray[index!.row]
                dest.clickedFarm = produce.farm
            }
        }
    }
    
    
    @IBAction func changeSegment(_ sender: Any) {
        tableView.reloadData()
        print("value changed")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("search detected")
        guard !searchText.isEmpty else {
            
            if category.selectedSegmentIndex == 0 {
                //                farmArray = CoreDataManager1.fetchFarm()
                tableView.reloadData()
                print("farm data reload")
                return
            }
            else {
                
                tableView.reloadData()
                print("produce data reload")
                return
            }
        }
        
        if category.selectedSegmentIndex == 0 { // search by farm
            farmArray = CoreDataManager1.fetchFarmObjects(selectedScopeIdx: 4, targetText:searchText)
            print(searchText)
            tableView.reloadData()
            print("farm data reload")
            print(searchText)
        }
        else { // search by produce
            produceArray = CoreDataManager1.fetchProduceObjects(selectedScopeIdx: 0, targetText: searchText)
            print(searchText)
            tableView.reloadData()
            print("produce data reload")
            print(searchText)
        }
        
    }

    
}

@available(iOS 10.0, *)
extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if category.selectedSegmentIndex == 0 { // search by farm
            print(farmArray.count)
            return farmArray.count
        }
        else { // search by produce
            print(produceArray.count)
            return produceArray.count
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("******populating table")
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.reuseIdentifier, for: indexPath) as? SearchTableViewCell else {
            fatalError("Unexpected Index Path")
        }

        if category.selectedSegmentIndex == 0 { // search by farm
            let farm = farmArray[indexPath.row]
            print("fetching indexPath \(indexPath.row)")
            print("farm has name \(farm.name)")
            // Configure Cell
            cell.nameLabel.text = farm.name
            cell.detailLabel.text = farm.postal
        }
        else { // search by produce
            let produce = produceArray[indexPath.row]
            print("fetching indexPath \(indexPath.row)")
            print("produce has name \(produce.name)")
            // Configure Cell
            cell.nameLabel.text = produce.name
            cell.detailLabel.text = produce.farm?.name
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100.0;//Choose your custom row height
    }
    
}

@available(iOS 10.0, *)
extension SearchViewController: NSFetchedResultsControllerDelegate {}
