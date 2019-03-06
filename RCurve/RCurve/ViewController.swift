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
    
    // Time
    var bigHrs : Int = 0
    var bigMins : Int = 0
    
    var smallHrs : Int = 0
    var smallMins : Int = 0
    
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
        
        (self.bigHrs, self.bigMins) = self.getUpdatedTime(hrs: 0, mins: 0, angle: self.bigAngle)
        
        self.bigtime.text = "\(self.bigHrs):\(self.bigMins)"
        self.smalltime.text = "24:00"
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
        self.bigAngle = self.bigAngle * 180.0 / .pi
        while self.bigAngle > 360.0 {
            self.bigAngle = self.bigAngle - 360.0
        }
        
        while self.bigAngle < 0.0 {
            self.bigAngle = self.bigAngle + 360.0
        }
        
        self.bigAngle = self.bigAngle * .pi / 180.0
//        if self.bigAngle > 360.0 {
//            self.bigAngle = self.bigAngle - 360.0
//            self.smallAngle = self.smallAngle + 360.0
//        } else if smallAngle > 360 {
//            self.smallAngle = self.smallAngle - 360.0
//            self.bigAngle = self.bigAngle + 360.0
//        }
    }

    @objc private func handleGesture(_ gesture: RotationGestureRecognizer) {
        print(((gesture.diff * 180.0 / .pi) * 1440) / 360)
//        self.viewAngle = self.viewAngle - gesture.diff
        
        self.smallAngle = self.smallAngle - gesture.diff
        self.bigAngle = self.bigAngle - gesture.diff
        self.correctAngles()
        
        self.curveView.masterTLayer.transform = CATransform3DMakeRotation(self.smallAngle, 0.0, 0.0, 1.0)
        self.curveView.backLayer.transform = CATransform3DMakeRotation(self.bigAngle, 0.0, 0.0, 1.0)
        
        
        
        (self.bigHrs, self.bigMins) = self.getTimeForAngle()
        
        self.bigtime.text = "\(self.bigHrs) : \(self.bigMins)"
        
        (self.smallHrs,self.smallMins) = self.getSmallTime()
        
        self.smalltime.text = "\(self.smallHrs) : \(self.smallMins)"
        
//        (self.bigHrs, self.bigMins) = self.getUpdatedTime(hrs: bigHrs, mins: bigMins, angle: gesture.diff)
//        (self.smallHrs, self.smallMins) = self.getUpdatedTime(hrs: smallHrs, mins: smallMins, angle: gesture.diff)
//
//        self.bigtime.text = "\(self.bigHrs) : \(self.bigMins)"
//        self.smalltime.text = "\(self.smallHrs) : \(self.smallMins)"
        
        
//        if gesture.layerName == "Mlayer" {
//
//            self.smallAngle = self.smallAngle - gesture.diff
//            self.bigAngle = self.bigAngle + gesture.diff
//            self.correctAngles()
//
//            self.curveView.masterTLayer.transform = CATransform3DMakeRotation(self.smallAngle, 0.0, 0.0, 1.0)
//            self.curveView.backLayer.transform = CATransform3DMakeRotation(self.bigAngle, 0.0, 0.0, 1.0)
//            self.bigtime.text = "\(self.bigAngle * 180 / .pi)"
//            self.smalltime.text = "\(self.smallAngle * 180 / .pi)"
//
//        } else {
//
//            self.smallAngle = self.smallAngle + gesture.diff
//            self.bigAngle = self.bigAngle - gesture.diff
//            self.correctAngles()
//            self.curveView.masterTLayer.transform = CATransform3DMakeRotation(self.smallAngle, 0.0, 0.0, 1.0)
//            self.curveView.backLayer.transform = CATransform3DMakeRotation(self.bigAngle, 0.0, 0.0, 1.0)
//            self.bigtime.text = "\(self.bigAngle * 180 / .pi)"
//            self.smalltime.text = "\(self.smallAngle * 180 / .pi)"
//
//        }
        
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
    
    
    // Time Calculation
    
    func getTimeForAngle() -> (Int,Int) {
        let angle = Int(self.bigAngle * 180.0 / .pi)
        var mins = angle * 4
        var hrs = mins / 60
        mins = mins % 60
        
        hrs = 24 - hrs
        
        
        return (hrs,mins)
    }
    
    func getSmallTime() -> (Int,Int) {
        
        var min = Int(self.timeDifferenceInSeconds / 60)
        var hr = 0
        
        hr = min / 60
        min = min % 60
        
        
        min = self.bigMins + min
        var morehr = 0
        if min > 60 {
            min = min - 60
            morehr = 1
        }
        
        hr = self.bigHrs + hr + morehr
        if hr > 24 {
            hr = hr - 24
        }
        
        return (hr,min)
    }
    
    func getUpdatedTime(hrs: Int, mins: Int, angle: CGFloat) -> (Int,Int) {
        var dmins = Int(((abs(angle) * 180.0 / .pi) * 1440) / 360) + mins
        var dhrs = mins / 60
        dmins = dmins % 60
        
        dhrs = (dhrs + hrs) % 24
        
        return (dhrs,dmins)
    }
}

