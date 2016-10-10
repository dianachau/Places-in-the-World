//
//  postersCollectionViewController.swift
//  searchBarTableView
//
//  Created by Diana on 10/4/16.
//  Copyright © 2016 diana. All rights reserved.
//

import UIKit

private let reuseIdentifier = "posterCell"

class PostersCollectionViewController: UICollectionViewController, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: UICollectionViewDataSource
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.featuredPosters.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! PosterCollectionViewCell

        let row = model.featuredPosters[indexPath.row]
            
        cell.posterImageView.image = UIImage(named: row["image"]!)
        cell.posterLabel.text = row["title"]
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(PostersCollectionViewController.posterImageViewTapped(_:)))
//        tap.numberOfTapsRequired = 1
//        cell.posterImageView.userInteractionEnabled = true;
//        cell.posterImageView.addGestureRecognizer(tap)
//        tap.delegate = self
        
        return cell
    }
    
    // MARK: - Tap Gesture
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
//    func posterImageViewTapped(recognizer: UITapGestureRecognizer) {
//        if(recognizer.state == UIGestureRecognizerState.Ended) {
//            print("image was tapped")
//        }
//    }
    
    // MARK: - Prepare for Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "imageViewSegue" {
            let postVC = segue.destinationViewController as! ImageViewController
            let cell = sender as! UICollectionViewCell
            let indexPath = collectionView?.indexPathForCell(cell)
            
            postVC.row = model.featuredPosters[indexPath!.row]
        }
    }
    
}
