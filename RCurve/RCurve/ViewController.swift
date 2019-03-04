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

    @IBOutlet weak var meetingTitle: UILabel!
    @IBOutlet weak var meetingDate: UILabel!
    
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var doneBtn: UIButton!
    
    
    
    var meeting_title : String = ""
    var meeting_date  : String = ""
    
    @IBOutlet weak var curveView: Curve!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gestureRecognizer = RotationGestureRecognizer(target: self, action: #selector(self.handleGesture(_:)))
        
        self.curveView.addGestureRecognizer(gestureRecognizer)
        self.bigAngle = CGFloat(self.timeDifferenceInSeconds * (360.0 / (86400))) * (CGFloat.pi / 180.0)
        self.initializeAngles()
        self.setupMeetingInfo()
        self.setupButtons()
    }
    
    func setupMeetingInfo() {
        self.meetingTitle.text = self.meeting_title
        self.meetingDate.text =  "On " + self.meeting_date
    }
    
    func initializeAngles() {
        self.curveView.masterTLayer.transform = CATransform3DMakeRotation(self.smallAngle, 0.0, 0.0, 1.0)
        self.curveView.backLayer.transform = CATransform3DMakeRotation(self.bigAngle, 0.0, 0.0, 1.0)
        self.bigtime.text = "\(self.bigAngle * 180 / .pi)"
        self.smalltime.text = "\(self.smallAngle * 180 / .pi)"
    }
    
    func setupButtons() {
        let btns : [UIButton] = [self.backBtn,self.doneBtn]
        for btn in btns {
            btn.layer.borderColor = UIColor.blue.cgColor
            btn.layer.borderWidth = 0.5
            btn.layer.cornerRadius = 4.0
        }
        
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
        print(gesture.diff * .pi / 180.0)
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
    
    @IBAction func backClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func doneClicked(_ sender: Any) {
        print("Done Now")
    }
    
}

