//
//  ImageViewController.swift
//  multipleCollectionView
//
//  Created by Diana on 10/7/16.
//  Copyright © 2016 diana. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    // MARK: - Variables
    var row: NSDictionary?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let row = row {
            imageView.image = UIImage(named: row["image"] as! String)
            titleLabel.text = row["title"] as? String
            descriptionLabel.text = row["description"] as? String
            photographerLabel.text = row["photographer"] as? String
            ratingsLabel.text = row["rating"] as? String

        }
    }
    
    // MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var photographerLabel: UILabel!
    @IBOutlet weak var ratingsLabel: UILabel!
}


