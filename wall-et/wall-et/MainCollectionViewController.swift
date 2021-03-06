//
//  MainCollectionViewController.swift
//  wall-et
//
//  Created by Kenneth Lam on 4/24/16.
//  Copyright © 2016 Calvin and Kenneth. All rights reserved.
//

import UIKit
import Foundation

class MainCollectionViewController: UICollectionViewController {
    
    var dictionaryOfItemsAndPrices = [String : Int]()
    var dictionaryOfItemsAndSavings = [String : Int]()
    var dictionaryOfItemsAndDates = [String : NSDate]()
    var dictionaryOfFinishedItemsAndPrices = [String : Int]()
    var dictionaryOfFinishedItemsAndDates = [String : NSDate]()
    var dictionaryOfDatesAndSavings = [NSDate : Int]()
    var selectedItem : String!
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
        
    }
    
    override func viewDidLoad() {
        //example items
        dictionaryOfItemsAndPrices = ["banana" : 10]
        dictionaryOfItemsAndSavings = ["banana" : 0]
        super.viewDidLoad()
        self.collectionView?.backgroundColor = UIColor.whiteColor()
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dictionaryOfItemsAndPrices.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CellViewController
        
        collectionView.backgroundColor = UIColor.whiteColor()
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRectMake(0, cell.frame.height - 1, cell.frame.width, 1)
        bottomBorder.backgroundColor = UIColor.grayColor().CGColor
        cell.layer.addSublayer(bottomBorder)
        
        //load the text and progress circle
        var keys = Array(dictionaryOfItemsAndPrices.keys).sort()
        let name = keys[indexPath.row]
        
        cell.itemName.text = name
        cell.itemPrice.text = "Price: $" + String(dictionaryOfItemsAndPrices[name]!)
        
        //add progress circle
        var savedOverPrice = Float(dictionaryOfItemsAndSavings[name]!)/Float(dictionaryOfItemsAndPrices[name]!)
        let percentage = savedOverPrice * 100.0
        let percentageString = String(Int(percentage)) + "%"
        if savedOverPrice == 0 {
            savedOverPrice += 0.005
        }
        cell.addCircleView(0.0, end: CGFloat(savedOverPrice), x: CGFloat(100), y: CGFloat(-50), savedOverPricing: percentageString)
        
        let cSelector = Selector("reset:")
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: cSelector)
        leftSwipe.direction = UISwipeGestureRecognizerDirection.Left
        cell.addGestureRecognizer(leftSwipe)
        
        return cell
    }
    
    func reset(sender: UISwipeGestureRecognizer) {
        let cell = sender.view as! CellViewController
        
        let deleteAlert = UIAlertController(title: "Wall-Et", message: "Delete \"" + cell.itemName.text! + "\"?", preferredStyle: UIAlertControllerStyle.Alert)
        
        deleteAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in
            //do nothing
        }))
        
        deleteAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            
            for cell in self.collectionView!.visibleCells() as [UICollectionViewCell] {
                for view in cell.subviews {
                    if view.isKindOfClass(CircleBar) || view.isKindOfClass(UILabel) {
                        view.removeFromSuperview()
                    }
                }
            }
            
            self.dictionaryOfItemsAndPrices.removeValueForKey(cell.itemName.text!)
            self.dictionaryOfItemsAndSavings.removeValueForKey(cell.itemName.text!)
            self.dictionaryOfItemsAndDates.removeValueForKey(cell.itemName.text!)
            self.collectionView?.reloadData()
        }))
        
        presentViewController(deleteAlert, animated: true, completion: nil)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 600, height: 100)
    }
    
    override func collectionView(collectionView: UICollectionView,
        didSelectItemAtIndexPath indexPath: NSIndexPath) {
            var keys = Array(dictionaryOfItemsAndPrices.keys).sort()
            selectedItem = keys[indexPath.row]
            performSegueWithIdentifier("singleItemSelectSegue", sender: indexPath)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "singleItemSelectSegue" {
            let singleItemViewController = segue.destinationViewController as! AdjustSavingsForItemViewController
            singleItemViewController.itemName = selectedItem!
            singleItemViewController.mainViewController = self
        } else if segue.identifier == "addSegue" {
            let addViewController = segue.destinationViewController as! AddItemToCollectionViewController
            addViewController.mainViewController = self
        } else if segue.identifier == "statisticsSegue" {
            let statisticsViewController = segue.destinationViewController as! SavingAndSpendingStatisticsViewController
            statisticsViewController.dictionaryOfDatesAndSavings = dictionaryOfDatesAndSavings
        } else if segue.identifier == "finishedSegue" {
            let finishedViewController = segue.destinationViewController as! FinishedItemsHistoryViewController
            finishedViewController.dictionaryOfFinishedItemsAndPrices = dictionaryOfFinishedItemsAndPrices
            finishedViewController.dictionaryOfFinishedItemsAndDates = dictionaryOfFinishedItemsAndDates
            finishedViewController.mainViewController = self
        }
    }
    
}

