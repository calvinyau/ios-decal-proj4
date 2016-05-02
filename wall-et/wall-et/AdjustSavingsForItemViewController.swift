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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadInterface()
    }
    
    func updateButtonFunction() {
        if (Int(savingsTextField.text!) == nil) {
            self.presentViewController(savingsAlertController!, animated: true, completion: nil)
        } else {
            mainViewController.dictionaryOfItemsAndSavings[itemName!] = Int(savingsTextField.text!)
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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

