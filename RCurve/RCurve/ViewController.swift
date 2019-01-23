//
//  ViewController.swift
//  RCurve
//
//  Created by Sandeep Joshi on 9/15/18.
//  Copyright © 2018 Sandeep Joshi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var prevAngle : CGFloat = 0
    var viewAngle : CGFloat = 0
    
    var bigAngle : CGFloat = 0
    var smallAngle : CGFloat = 0
    
    @IBOutlet weak var curveView: Curve!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gestureRecognizer = RotationGestureRecognizer(target: self, action: #selector(self.handleGesture(_:)))
        
        self.curveView.addGestureRecognizer(gestureRecognizer)
        
    }
    

    @objc private func handleGesture(_ gesture: RotationGestureRecognizer) {
        
//        self.viewAngle = self.viewAngle - gesture.diff
        if gesture.layerName == "Mlayer" {
            self.smallAngle = self.smallAngle - gesture.diff
            self.bigAngle = self.bigAngle + gesture.diff
            self.curveView.masterTLayer.transform = CATransform3DMakeRotation(self.smallAngle, 0.0, 0.0, 1.0)
            self.curveView.backLayer.transform = CATransform3DMakeRotation(self.bigAngle, 0.0, 0.0, 1.0)
        } else {
            self.smallAngle = self.smallAngle + gesture.diff
            self.bigAngle = self.bigAngle - gesture.diff
            self.curveView.masterTLayer.transform = CATransform3DMakeRotation(self.smallAngle, 0.0, 0.0, 1.0)
            self.curveView.backLayer.transform = CATransform3DMakeRotation(self.bigAngle, 0.0, 0.0, 1.0)
        }
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func rotate(_ sender: Any) {
        curveView.rotate()
    }
    
}

