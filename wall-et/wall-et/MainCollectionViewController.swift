//
//  MainCollectionViewController.swift
//  wall-et
//
//  Created by Kenneth Lam on 4/24/16.
//  Copyright © 2016 Calvin and Kenneth. All rights reserved.
//

import UIKit

class MainCollectionViewController: UICollectionViewController {
    
    var dictionaryOfItemsAndPrices = [String : Int]()
    var dictionaryOfItemsAndSavings = [String : Int]()
    var selectedItem : String!
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
        
    }
    
    override func viewDidLoad() {
        dictionaryOfItemsAndPrices = ["calvin" : 1, "sunny" : 2, "justin" : 3]
        dictionaryOfItemsAndSavings = ["calvin" : 0, "sunny" : 1, "justin" : 2]
        super.viewDidLoad()
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
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.blackColor().CGColor
        
        //load the text and progress circle
        var keys = Array(dictionaryOfItemsAndPrices.keys).sort()
        let name = keys[indexPath.row]
        cell.itemName.text = name
        cell.itemSavings.text = "$" + String(dictionaryOfItemsAndSavings[name]!) + " / " + "$" + String(dictionaryOfItemsAndPrices[name]!)
        //add progress circle
        
        return cell
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
            //stuff
        }
    }
    
}

