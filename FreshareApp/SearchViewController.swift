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
class SearchViewController: UIViewController {
    
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    // MARK: -
    
    private func setupMessageLabel() {
        messageLabel.text = "There is nothing to display."
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
