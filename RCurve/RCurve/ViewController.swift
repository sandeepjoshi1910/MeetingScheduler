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
    
    // Time outlets
    // Time Zone One
    @IBOutlet weak var timeZoneNameOne: UILabel!
    @IBOutlet weak var toneStartTime: UILabel!
    @IBOutlet weak var toneEndTime: UILabel!
    
    // Time Zone Two
    @IBOutlet weak var timeZoneNameTwo: UILabel!
    @IBOutlet weak var ttwoStartTime: UILabel!
    @IBOutlet weak var ttwoEndTime: UILabel!
    
    // Time Zone Views
    @IBOutlet weak var tZoneOneView: UIView!
    @IBOutlet weak var tZoneTwoView: UIView!
    
    
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
        self.setupTimeZoneUI()
    }
    
    func setupTimeZoneUI() {
        // Add shadow to each of the view of both timeZones
        let views : [UIView] = [tZoneOneView,tZoneTwoView]
        
        for view in views {
//            view.layer.borderColor = UIColor.red.cgColor
//            view.layer.borderWidth = 0.5
            view.layer.shadowColor = UIColor.lightGray.cgColor
            view.layer.shadowRadius = 6.0
            view.layer.shadowOpacity = 0.4
            view.layer.shadowOffset = CGSize.zero
            view.layer.cornerRadius = 5.0
        }
    }
    
    func setupMeetingInfo() {
        self.meetingTitle.text = self.meeting_title
        self.meetingDate.text =  "On " + self.meeting_date
    }
    
    func initializeAngles() {
        self.curveView.masterTLayer.transform = CATransform3DMakeRotation(self.smallAngle, 0.0, 0.0, 1.0)
        self.curveView.backLayer.transform = CATransform3DMakeRotation(self.bigAngle, 0.0, 0.0, 1.0)
        
        (self.bigHrs, self.bigMins) = self.getUpdatedTime(hrs: 0, mins: 0, angle: self.bigAngle)
        
        (self.bigHrs, self.bigMins) = self.getTimeForAngle()
        
        self.toneStartTime.text = "\(self.bigHrs) : \(self.bigMins)"
        let (eoneh,eonem) = self.getEndTime(hrs: self.bigHrs, mins: self.bigMins, duration: 90)
        self.toneEndTime.text = "\(eoneh) : \(eonem)"
        
        (self.smallHrs,self.smallMins) = self.getSmallTime()
        
        self.ttwoStartTime.text = "\(self.smallHrs) : \(self.smallMins)"
        let (etwoh, etwom) = self.getEndTime(hrs: self.smallHrs, mins: self.smallMins, duration: 90)
        
        self.ttwoEndTime.text = "\(etwoh) : \(etwom)"
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
        
        self.toneStartTime.text = "\(self.bigHrs) : \(self.bigMins)"
        let (eoneh,eonem) = self.getEndTime(hrs: self.bigHrs, mins: self.bigMins, duration: 90)
        self.toneEndTime.text = "\(eoneh) : \(eonem)"
        
        (self.smallHrs,self.smallMins) = self.getSmallTime()
        
        self.ttwoStartTime.text = "\(self.smallHrs) : \(self.smallMins)"
        let (etwoh, etwom) = self.getEndTime(hrs: self.smallHrs, mins: self.smallMins, duration: 90)
        
        self.ttwoEndTime.text = "\(etwoh) : \(etwom)"
        
        
        self.timeZoneNameOne.text = "CST"
        self.timeZoneNameTwo.text = "PST"
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
        var mins = (angle * 4) + 44
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
    
    func getEndTime(hrs:Int,mins:Int,duration:Int) -> (Int,Int){
        
        var h = hrs
        var m = mins
        m = m + duration
        if (m / 60) > 0 {
            h = h + (m / 60)
        }
        m = m % 60
        h = h % 24
        
        return (h,m)
    }
}

