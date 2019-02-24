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
    
    var timeDifferenceInSeconds : Float = 0
    
    var bigAngle : CGFloat = 0
    var smallAngle : CGFloat = 0
    @IBOutlet weak var bigtime: UILabel!
    @IBOutlet weak var smalltime: UILabel!
    @IBOutlet weak var meetingtitle: UILabel!
    
    @IBOutlet weak var curveView: Curve!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gestureRecognizer = RotationGestureRecognizer(target: self, action: #selector(self.handleGesture(_:)))
        
        self.curveView.addGestureRecognizer(gestureRecognizer)
        self.bigAngle = CGFloat(self.timeDifferenceInSeconds * (360.0 / (86400))) * (CGFloat.pi / 180.0)
        self.initializeAngles()
    }
    
    func initializeAngles() {
        self.curveView.masterTLayer.transform = CATransform3DMakeRotation(self.smallAngle, 0.0, 0.0, 1.0)
        self.curveView.backLayer.transform = CATransform3DMakeRotation(self.bigAngle, 0.0, 0.0, 1.0)
        self.bigtime.text = "\(self.bigAngle * 180 / .pi)"
        self.smalltime.text = "\(self.smallAngle * 180 / .pi)"
    }
    
    func correctAngles() {
        if self.bigAngle > 360.0 {
            self.bigAngle = self.bigAngle - 360.0
            self.smallAngle = self.smallAngle + 360.0
        } else if smallAngle > 360 {
            self.smallAngle = self.smallAngle - 360.0
            self.bigAngle = self.bigAngle + 360.0
        }
    }

    @objc private func handleGesture(_ gesture: RotationGestureRecognizer) {
        
//        self.viewAngle = self.viewAngle - gesture.diff
        if gesture.layerName == "Mlayer" {
            self.smallAngle = self.smallAngle - gesture.diff
            self.bigAngle = self.bigAngle + gesture.diff
            self.correctAngles()
            self.curveView.masterTLayer.transform = CATransform3DMakeRotation(self.smallAngle, 0.0, 0.0, 1.0)
            self.curveView.backLayer.transform = CATransform3DMakeRotation(self.bigAngle, 0.0, 0.0, 1.0)
            self.bigtime.text = "\(self.bigAngle * 180 / .pi)"
            self.smalltime.text = "\(self.smallAngle * 180 / .pi)"
        } else {
            self.smallAngle = self.smallAngle + gesture.diff
            self.bigAngle = self.bigAngle - gesture.diff
            self.correctAngles()
            self.curveView.masterTLayer.transform = CATransform3DMakeRotation(self.smallAngle, 0.0, 0.0, 1.0)
            self.curveView.backLayer.transform = CATransform3DMakeRotation(self.bigAngle, 0.0, 0.0, 1.0)
            self.bigtime.text = "\(self.bigAngle * 180 / .pi)"
            self.smalltime.text = "\(self.smallAngle * 180 / .pi)"
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

