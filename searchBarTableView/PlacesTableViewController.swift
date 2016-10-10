//
//  PlacesTableViewController.swift
//  searchBarTableView
//
//  Created by Diana on 10/3/16.
//  Copyright © 2016 diana. All rights reserved.
//

import UIKit

class PlacesTableViewController: UITableViewController, UISearchResultsUpdating {
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
//        initSearchController()
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active == true {
           return searchResults.count
        } else {
            return model.featuredPosters.count
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("placesCell", forIndexPath: indexPath)
        
        if searchController.active == true {
            cell.textLabel!.text = searchResults[indexPath.row]["description"] as? String

        } else {
            cell.textLabel!.text = model.featuredPosters[indexPath.row]["description"]
        }
        
        
        
        return cell
    }
    
    // MARK: - Search Controller
    let searchController = UISearchController(searchResultsController: nil)
    var searchResults = [AnyObject]()
    
    func initSearchController() {
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        // get data array
        // use text in search bar to filter results
        let predicate = NSPredicate(format: "description contains[cd] %@", searchController.searchBar.text!)
        let filteredResults = (model.featuredPosters as NSArray!).filteredArrayUsingPredicate(predicate)
        
        print(filteredResults)
        print("Number of Results: \(filteredResults.count)")
        
        // get new search results
        searchResults = filteredResults
        tableView.reloadData()
    }
}
