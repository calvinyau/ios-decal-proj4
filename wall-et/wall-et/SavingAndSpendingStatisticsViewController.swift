//
//  SavingAndSpendingStatisticsViewController.swift
//  wall-et
//
//  Created by Kenneth Lam on 4/24/16.
//  Copyright © 2016 Calvin and Kenneth. All rights reserved.
//

import UIKit

class SavingAndSpendingStatisticsViewController: UIViewController {
    
    @IBOutlet var totalLabel : UILabel!
    @IBOutlet var dayLabel : UILabel!
    @IBOutlet var weekLabel : UILabel!
    @IBOutlet var monthLabel : UILabel!
    @IBOutlet var yearLabel : UILabel!
    @IBOutlet var titleLabel : UILabel!
    
    var dictionaryOfDatesAndSavings : [NSDate : Int]!
    
    var total : Int = 0
    var day : Int = 0
    var week : Int = 0
    var month : Int = 0
    var year : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadInterface()
    }
    
    func loadInterface() {
        let keys = Array(dictionaryOfDatesAndSavings.keys)
        for date in keys {
            let timeDifference = NSDate().timeIntervalSinceDate(date);
            if (timeDifference <= 86400) {
                day += dictionaryOfDatesAndSavings[date]!
            }
            if (timeDifference <= 604800) {
                week += dictionaryOfDatesAndSavings[date]!
            }
            if (timeDifference <= 2592000) {
                month += dictionaryOfDatesAndSavings[date]!
            }
            if (timeDifference <= 31557600) {
                year += dictionaryOfDatesAndSavings[date]!
            }
            total += dictionaryOfDatesAndSavings[date]!
        }
        
        titleLabel.text = "Savings Over Time"
        totalLabel.text = "Total: $" + String(total)
        dayLabel.text = "Day: $" + String(day)
        weekLabel.text = "Week: $" + String(week)
        monthLabel.text = "Month: $" + String(month)
        yearLabel.text = "Year: $" + String(year)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

