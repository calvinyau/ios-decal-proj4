//
//  FinishedItemsHistoryViewController.swift
//  wall-et
//
//  Created by Kenneth Lam on 4/24/16.
//  Copyright © 2016 Calvin and Kenneth. All rights reserved.
//

import UIKit

class FinishedItemsHistoryViewController: UICollectionViewController {
    
    @IBOutlet var mainViewController : MainCollectionViewController!
    
    var dictionaryOfFinishedItemsAndPrices : [String : Int]!
    var dictionaryOfFinishedItemsAndDates : [String : NSDate]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.backgroundColor = UIColor.whiteColor()
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dictionaryOfFinishedItemsAndPrices.count + 1
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("finishedCell", forIndexPath: indexPath) as! CellViewController
        
        if (indexPath.row == 0) {
            cell.finishedTitle.text = "Finished Items"
            cell.itemFinishedName.text = ""
            cell.itemFinishedDate.text = ""
            cell.itemFinishedPrice.text = ""
        } else {
            cell.finishedTitle.text = ""
            
            var keys = Array(dictionaryOfFinishedItemsAndPrices.keys).sort()
            let name = keys[indexPath.row - 1]
        
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateString = dateFormatter.stringFromDate(dictionaryOfFinishedItemsAndDates[name]!)
        
            cell.itemFinishedName.text = name
            cell.itemFinishedPrice.text = "Item Price: $" + String(dictionaryOfFinishedItemsAndPrices[name]!)
            cell.itemFinishedDate.text = "Completed: " + dateString
        }
        
        collectionView.backgroundColor = UIColor.whiteColor()
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRectMake(0, cell.frame.height - 1, cell.frame.width, 1)
        bottomBorder.backgroundColor = UIColor.lightGrayColor().CGColor
        cell.layer.addSublayer(bottomBorder)
        
        let cSelector = Selector("reset:")
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: cSelector)
        leftSwipe.direction = UISwipeGestureRecognizerDirection.Left
        cell.addGestureRecognizer(leftSwipe)
        
        return cell
    }
    
    func reset(sender: UISwipeGestureRecognizer) {
        let cell = sender.view as! CellViewController
        
        let deleteAlert = UIAlertController(title: "Wall-Et", message: "Delete \"" + cell.itemFinishedName.text! + "\"?", preferredStyle: UIAlertControllerStyle.Alert)
        
        deleteAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in
            //do nothing
        }))
        
        deleteAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            self.dictionaryOfFinishedItemsAndPrices.removeValueForKey(cell.itemFinishedName.text!)
            self.dictionaryOfFinishedItemsAndDates.removeValueForKey(cell.itemFinishedName.text!)
            self.mainViewController.dictionaryOfFinishedItemsAndPrices.removeValueForKey(cell.itemFinishedName.text!)
            self.mainViewController.dictionaryOfFinishedItemsAndDates.removeValueForKey(cell.itemFinishedName.text!)
            self.collectionView?.reloadData()
        }))
        
        presentViewController(deleteAlert, animated: true, completion: nil)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 600, height: 100)
    }
    
    
}

