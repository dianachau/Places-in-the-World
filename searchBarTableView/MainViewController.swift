//
//  MainViewController.swift
//  multipleCollectionView
//
//  Created by Diana on 10/4/16.
//  Copyright © 2016 diana. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UISearchResultsUpdating, UISearchBarDelegate, UICollectionViewDataSource, UICollectionViewDelegate {

    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        chartsView.hidden = true
        blurView.hidden = true
        searchView.hidden = true
        initSegmentedControl()
        initNavigationItems()
    }

    // MARK: - Outlets
    @IBOutlet weak var featuredView: UIView!
    @IBOutlet weak var chartsView: UIView!
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var searchView: UICollectionView!

    // MARK: - Interactions
    func tapSegmentedControl(sender: UISegmentedControl) {
        toggleView(sender)
    }
    
    func tapSearchBarButton(sender: UIBarButtonItem) {
        initSearchController()
    }
    
    @IBAction func tapBlurView(sender: UIButton) {
        dismissSearch()
    }
    
    
    // MARK: - Segmented Control
    let segmentedControl = UISegmentedControl(items: ["Featured", "Charts"])
    
    func initSegmentedControl() {
        navigationItem.titleView = segmentedControl
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(MainViewController.tapSegmentedControl(_:)), forControlEvents: .ValueChanged)
    }
    
    func toggleView(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0: showFeaturedView()
        case 1: showChartsView()
        default: break
        }
    }
    
    func showFeaturedView() {
        featuredView.hidden = false
        chartsView.hidden = true
    }
    
    func showChartsView() {
        featuredView.hidden = true
        chartsView.hidden = false
    }
    
    // MARK: - Navigation Item
    var exploreButton: UIBarButtonItem?
    var searchButton: UIBarButtonItem?
    
    func initNavigationItems() {
        exploreButton = UIBarButtonItem(title: "Explore", style: .Plain, target: nil, action: nil)
        searchButton = UIBarButtonItem(barButtonSystemItem: .Search, target: self, action: #selector(MainViewController.tapSearchBarButton(_:)))
        
        navigationItem.leftBarButtonItem = exploreButton
        navigationItem.rightBarButtonItem = searchButton
        
    }
    
    // MARK: - Search Controller
    let searchController = UISearchController(searchResultsController: nil)
    var searchResults = [AnyObject]()
    var searchBar = UISearchBar()
    
    func initSearchController() {
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        
        searchBar = searchController.searchBar
        searchBar.becomeFirstResponder()
        searchBar.searchTextPositionAdjustment = UIOffset(horizontal: 7, vertical: 1)
        searchBar.delegate = self
        
        navigationItem.titleView = searchController.searchBar
        navigationItem.leftBarButtonItem = nil
        navigationItem.rightBarButtonItem = nil
        
        blurView.hidden = false
        blurView.alpha = 0
        UIView.animateWithDuration(0.2) { 
            self.blurView.alpha = 1
            self.searchView.alpha = 1
        }
    }
    
    func dismissSearch() {
        navigationItem.titleView = nil
        navigationItem.titleView = segmentedControl
        
        navigationItem.leftBarButtonItem = exploreButton
        navigationItem.rightBarButtonItem = searchButton
        
        UIView.animateWithDuration(0.2, animations: { 
            self.blurView.alpha = 0
            self.searchView.alpha = 0
            }) { (Bool) in
                self.blurView.hidden = true
                self.searchView.hidden = true
        }
        
    }
    
    // MARK: UISearchBarDelegate Protocol
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        dismissSearch()
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.characters.count == 0 {
            searchView.hidden = true
        } else {
            searchView.hidden = false
        }
    }
    
    // MARK: UISearchResultsUpdating Protocol
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        // get data array
        // use text in search bar to filter results
        let predicate = NSPredicate(format: "description contains[cd] %@", searchController.searchBar.text!)
        let filteredResults = (model.featuredPosters as NSArray!).filteredArrayUsingPredicate(predicate)
        
//        print(filteredResults)
//        print("Number of Results: \(filteredResults.count)")
        
        // get new search results
        searchResults = filteredResults
        searchView.reloadData()
    }
    
    // MARK: - Collection View Data Source
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("searchCell", forIndexPath: indexPath) as! PosterCollectionViewCell
        let row = searchResults[indexPath.row]
        
        cell.ro1 = indexPath.row
        cell.posterImageView.image = UIImage(named: row["image"] as! String)
        cell.posterLabel.text = row["title"] as? String
        
        return cell
    }
    
    // MARK: - Prepare for Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print(segue.identifier)

        
        if segue.identifier == "mainToImageViewSegue" {
            let postVC = segue.destinationViewController as! ImageViewController
            let cell = sender as! PosterCollectionViewCell

            postVC.row = searchResults[cell.ro1!] as? NSDictionary
        }
    }
    
}
