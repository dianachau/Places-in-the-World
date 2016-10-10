//
//  ChartsTableViewController.swift
//  multipleCollectionView
//
//  Created by Diana on 10/4/16.
//  Copyright © 2016 diana. All rights reserved.
//

import UIKit

class ChartsTableViewController: UITableViewController {

    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.charts.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("chartsCell", forIndexPath: indexPath) as! ChartsTableViewCell

        let row = model.charts[indexPath.row]
        
        cell.numberLabel.text = "\(indexPath.row + 1)"
        cell.posterImageView.image = UIImage(named: row["image"]!)
        cell.titleLabel.text = row["title"]
        cell.descriptionLabel.text = row["description"]
        cell.ratingsLabel.text = row["rating"]

        return cell
    }

}
