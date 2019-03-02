//
//  TimePickController.swift
//  RCurve
//
//  Created by Sandeep Joshi on 12/24/18.
//  Copyright © 2018 Sandeep Joshi. All rights reserved.
//

import UIKit
import CoreLocation
import TimeZonePicker

class TimePickController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var timeDiff = 0
    var meetingScheduler : ViewController = ViewController()
    
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var addTimeZoneBtn: UIButton!
    @IBOutlet weak var timeZoneCV: UICollectionView!
    var timeZones : [TimeZone] = []
    
    @IBOutlet weak var loclabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Collection View Setup
        timeZoneCV.register(UINib(nibName: "TimeZoneCell", bundle: nil), forCellWithReuseIdentifier: "timezoneview")
        timeZoneCV.dataSource = self
        timeZoneCV.delegate = self
        timeZoneCV.contentInset = UIEdgeInsets(top: 20.0, left: 0, bottom: 20.0, right: 0)
        
        self.setupButtons()
        
    }
    
    func setupButtons() {
        let btns : [UIButton] = [self.backBtn,self.addTimeZoneBtn,self.doneBtn]
        for btn in btns {
            btn.layer.borderColor = UIColor.blue.cgColor
            btn.layer.borderWidth = 0.5
            btn.layer.cornerRadius = 4.0
        }
        self.doneBtn.isEnabled = false
        self.doneBtn.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    // MARK : TimeZone Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.timeZones.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = timeZoneCV.dequeueReusableCell(withReuseIdentifier: "timezoneview", for: indexPath) as! TimeZoneCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15.0
    }
    

    @IBAction func selectTimeZ(_ sender: Any) {
        let timeZonePicker = TimeZonePickerViewController.getVC(withDelegate: self)
        present(timeZonePicker, animated: true, completion: nil)
    }
    
    @IBAction func selectMeetingTime(_ sender: Any) {
        let timeZoneDiff = abs(self.timeDiff)
        self.meetingScheduler = self.storyboard?.instantiateViewController(withIdentifier: "viewc") as! ViewController
        self.meetingScheduler.timeDifferenceInSeconds = Float(timeZoneDiff)
        present(self.meetingScheduler, animated: true, completion: nil)
    }
    
    
    @IBAction func addTimeZone(_ sender: Any) {
        let timeZonePicker = TimeZonePickerViewController.getVC(withDelegate: self)
        present(timeZonePicker, animated: true, completion: nil)
    }
    
    @IBAction func backClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension TimePickController: TimeZonePickerDelegate {
    
    func timeZonePicker(_ timeZonePicker: TimeZonePickerViewController, didSelectTimeZone timeZone: TimeZone) {
        self.loclabel.text = "\(timeZone.identifier) \(timeZone.abbreviation()!)"
        self.timeZones.append(timeZone)
        self.timeZoneCV.reloadData()
        
        if self.timeZones.count == 2 {
            self.addTimeZoneBtn.isEnabled = false
            self.addTimeZoneBtn.layer.borderColor = UIColor.lightGray.cgColor
            self.doneBtn.isEnabled = true
            self.doneBtn.layer.borderColor = UIColor.blue.cgColor
        }
//        timeZoneOffset.text = timeZone.abbreviation()
        self.timeDiff = timeZone.secondsFromGMT() - self.timeDiff
        timeZonePicker.dismiss(animated: true, completion: nil)
    }
    
}
