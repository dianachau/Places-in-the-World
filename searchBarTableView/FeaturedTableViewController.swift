//
//  MainTableViewController.swift
//  searchBarTableView
//
//  Created by Diana on 10/3/16.
//  Copyright © 2016 diana. All rights reserved.
//

import UIKit

class FeaturedTableViewController: UITableViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    // MARK: - Collection View Data Source
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.featuredBanners.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("bannerCellCollectionView", forIndexPath: indexPath) as! BannerCollectionViewCell
        
        cell.bannerImageView.image = UIImage(named: model.featuredBanners[indexPath.row]["image"]!)
        
        return cell
    }
    
}
