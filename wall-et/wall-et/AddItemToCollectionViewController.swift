//
//  AddItemToCollectionViewController.swift
//  wall-et
//
//  Created by Kenneth Lam on 4/24/16.
//  Copyright © 2016 Calvin and Kenneth. All rights reserved.
//

import UIKit

class AddItemToCollectionViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var addNameTextField: UITextField!
    @IBOutlet var addPriceTextField: UITextField!
    @IBOutlet var nameLabel : UILabel!
    @IBOutlet var priceLabel : UILabel!
    @IBOutlet var addButton : UIButton!
    @IBOutlet var mainViewController : MainCollectionViewController!
    
    var nameAlertController : UIAlertController?
    var repeatAlertController : UIAlertController?
    var priceAlertController : UIAlertController?
    var negativeAlertController : UIAlertController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadInterface()
    }
    
    func addButtonFunction() {
        if (addNameTextField.text!.isEmpty) {
            self.presentViewController(nameAlertController!, animated: true, completion: nil)
        } else if (mainViewController.dictionaryOfItemsAndPrices.keys.contains(addNameTextField.text!)) {
            self.presentViewController(repeatAlertController!, animated: true, completion: nil)
        } else if (Int(addPriceTextField.text!) == nil) {
            self.presentViewController(priceAlertController!, animated: true, completion: nil)
        } else if (Int(addPriceTextField.text!) <= 0) {
            self.presentViewController(negativeAlertController!, animated: true, completion: nil)
        } else {
            mainViewController.dictionaryOfItemsAndPrices[self.addNameTextField.text!] = Int(self.addPriceTextField.text!)
            mainViewController.dictionaryOfItemsAndDates[self.addNameTextField.text!] = NSDate()
            mainViewController.dictionaryOfItemsAndSavings[addNameTextField.text!] = 0
            
            for view in mainViewController.view.subviews {
                if view.isKindOfClass(CircleBar) || view.isKindOfClass(UILabel) {
                    view.removeFromSuperview()
                }
            }
            
            mainViewController.collectionView?.reloadData()
            self.performSegueWithIdentifier("unwindToMain", sender: self)
        }
    }
    
    func loadInterface() {
        addNameTextField.delegate = self
        addPriceTextField.delegate = self
        addButton.addTarget(self, action: "addButtonFunction", forControlEvents: .TouchUpInside)
        addButton.layer.borderWidth = 1.0
        addButton.layer.borderColor = UIColor(red: 0, green: 100/255, blue: 250/255, alpha: 0.5).CGColor
        addButton.layer.cornerRadius = 4.0
        nameAlertController = UIAlertController(title: "Wall-Et", message:
            "Name Cannot Be Empty!", preferredStyle: UIAlertControllerStyle.Alert)
        nameAlertController!.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        repeatAlertController = UIAlertController(title: "Wall-Et", message:
            "The List Already Contains This Item!", preferredStyle: UIAlertControllerStyle.Alert)
        repeatAlertController!.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        priceAlertController = UIAlertController(title: "Wall-Et", message:
            "Price Must Be A Number!", preferredStyle: UIAlertControllerStyle.Alert)
        priceAlertController!.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        negativeAlertController = UIAlertController(title: "Wall-Et", message:
            "No Zero or Negative Prices!", preferredStyle: UIAlertControllerStyle.Alert)
        negativeAlertController!.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

