//
//  AdjustSavingsForItemViewController.swift
//  wall-et
//
//  Created by Kenneth Lam on 4/24/16.
//  Copyright © 2016 Calvin and Kenneth. All rights reserved.
//

import UIKit

class AdjustSavingsForItemViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var mainViewController : MainCollectionViewController!
    @IBOutlet var updateButton : UIButton!
    @IBOutlet var savingsTextField : UITextField!
    var itemName : String!
    
    var savingsAlertController : UIAlertController?
    var negativeAlertController : UIAlertController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadInterface()
    }
    
    func updateButtonFunction() {
        if (Int(savingsTextField.text!) == nil) {
            self.presentViewController(savingsAlertController!, animated: true, completion: nil)
        } else if (mainViewController.dictionaryOfItemsAndSavings[itemName]! + Int(savingsTextField.text!)! < 0) {
            self.presentViewController(negativeAlertController!, animated: true, completion: nil)
        } else {
            for cell in mainViewController.collectionView!.visibleCells() as [UICollectionViewCell] {
                for view in cell.subviews {
                    if view.isKindOfClass(CircleBar) || view.isKindOfClass(UILabel) {
                        view.removeFromSuperview()
                    }
                }
            }
            
            if (Int(savingsTextField.text!)! + mainViewController.dictionaryOfItemsAndSavings[itemName]! >= mainViewController.dictionaryOfItemsAndPrices[itemName]!) {
                let finishedKeys = Array(mainViewController.dictionaryOfFinishedItemsAndPrices.keys).sort()
                if (finishedKeys.contains(itemName)) {
                    var index = 1
                    while (finishedKeys.contains(itemName + " (" + String(index) + ")")) {
                        index += 1
                    }
                    mainViewController.dictionaryOfFinishedItemsAndPrices[itemName + " (" + String(index) + ")"] = mainViewController.dictionaryOfItemsAndPrices[itemName]!
                    mainViewController.dictionaryOfFinishedItemsAndDates[itemName + " (" + String(index) + ")"] = NSDate()
                } else {
                    mainViewController.dictionaryOfFinishedItemsAndPrices[itemName] = mainViewController.dictionaryOfItemsAndPrices[itemName]!
                    mainViewController.dictionaryOfFinishedItemsAndDates[itemName] = NSDate()
                }
                mainViewController.dictionaryOfItemsAndPrices.removeValueForKey(itemName)
                mainViewController.dictionaryOfItemsAndSavings.removeValueForKey(itemName)
                mainViewController.dictionaryOfItemsAndDates.removeValueForKey(itemName)
            } else {
                mainViewController.dictionaryOfItemsAndSavings[itemName!] = mainViewController.dictionaryOfItemsAndSavings[itemName!]! + Int(savingsTextField.text!)!
            }
            mainViewController.dictionaryOfDatesAndSavings[NSDate()] = Int(savingsTextField.text!)
            mainViewController.collectionView?.reloadData()
            self.performSegueWithIdentifier("unwindToMainFromAdjust", sender: self)
        }
    }
    
    func loadInterface() {
        savingsTextField.delegate = self
        updateButton.addTarget(self, action: "updateButtonFunction", forControlEvents: .TouchUpInside)
        updateButton.layer.borderWidth = 1.0
        updateButton.layer.borderColor = UIColor(red: 0, green: 100/255, blue: 250/255, alpha: 0.5).CGColor
        updateButton.layer.cornerRadius = 4.0
        savingsAlertController = UIAlertController(title: "Wall-Et", message:
            "Savings Must Be A Number!", preferredStyle: UIAlertControllerStyle.Alert)
        savingsAlertController!.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        negativeAlertController = UIAlertController(title: "Wall-Et", message:
            "No Negative Savings!", preferredStyle: UIAlertControllerStyle.Alert)
        negativeAlertController!.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

