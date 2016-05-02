//
//  CellViewController.swift
//  wall-et
//
//  Created by Kenneth Lam on 4/24/16.
//  Copyright © 2016 Calvin and Kenneth. All rights reserved.
//

import UIKit
class CellViewController: UICollectionViewCell {
    
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemFinishedDate: UILabel!
    @IBOutlet weak var itemFinishedName: UILabel!
    @IBOutlet weak var itemFinishedPrice: UILabel!
    @IBOutlet weak var finishedTitle: UILabel!
    
    func addCircleView(start: CGFloat, end: CGFloat, x: CGFloat, y: CGFloat, savedOverPricing: String) {
        let circleWidth = CGFloat(200)
        let circleHeight = circleWidth
        
        let label = UILabel(frame: CGRectMake(x, y, circleWidth, circleHeight))
        label.textAlignment = NSTextAlignment.Center
        label.text = savedOverPricing
        self.addSubview(label)
        
        // Create a new CircleBar
        let circleView = CircleBar(frame: CGRectMake(x, y, circleWidth, circleHeight))
        
        self.addSubview(circleView)
        
        // Animate the drawing of the circle over the course of 1 second from start to end
        circleView.animateCircle(2.0, startValue: start, endValue: end)
    }
}
