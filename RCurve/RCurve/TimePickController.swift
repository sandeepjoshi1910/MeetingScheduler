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

class TimePickController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, TimeZoneDelegateProtocol {
    
    var timeDiff = 0
    var meetingScheduler : ViewController = ViewController()
    
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var addTimeZoneBtn: UIButton!
    @IBOutlet weak var timeZoneCV: UICollectionView!
    
    
    @IBOutlet weak var meetingTitle: UITextField!
    @IBOutlet weak var meetingDate: UITextField!
    @IBOutlet weak var meetingDuration: UITextField!
    
    
    var datePicker : UIDatePicker?
    let maxNumTimeZones : Int = 2
    var meetDate : Date? = nil
    var meetingDateComps : DateComponents? = nil
    
    var timeZones : [TimeZone] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTimeZoneCollectionView()
        setupButtons()
        setupDatePicker()
        setupGestureRecognizer()
        
        self.meetingDateComps = DateComponents()
    }
    
    
    // MARK: - Handling Clicks
    
    // Date selected
    @objc func dateChanged(datePicker : UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        self.meetingDate.text = dateFormatter.string(from: datePicker.date)
        self.meetDate = datePicker.date
        let comps = self.meetingDate.text?.components(separatedBy: "/")
        self.meetingDateComps!.month = Int(comps![0])
        self.meetingDateComps!.day = Int(comps![1])
        self.meetingDateComps!.year = Int(comps![2])
//        let x = Calendar.current.dateComponents(in: TimeZone.init(secondsFromGMT: 19800)!, from: datePicker.date)
    }
    
    // Dismiss the keyboard when tapped on the screen
    @objc func viewTapped(gesture : UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
//    func createMeetingData() -> TMeeting{
//        let newMeeting = TMeeting()
////        newMeeting.meetingDurationInMins = Int(self.meetingDuration.text!)
////        for timeZone in self.timeZones {
////            newMeeting.meetingDict[timeZone] = TMeetingTime()
////            newMeeting.timeZones?.append(timeZone)
////        }
////        newMeeting.meetingDate = self.meetDate!
//        return newMeeting
//    }
    
    func updateMeetingData() -> TMeeting {
        let meeting = TMeeting()
        for timeZone in self.timeZones {
            let meetingTime = TMeetingTime()
            meetingTime.startTime = self.meetDate!
            var dateComp = DateComponents()
            dateComp.second = timeZone.secondsFromGMT()
            meetingTime.startTime = Calendar.current.date(byAdding: dateComp, to: meetingTime.startTime!)
            
            meetingTime.endTime = self.meetDate!
            dateComp.second = timeZone.secondsFromGMT() + (Int(self.meetingDuration.text!)! * 60)
            meetingTime.endTime = Calendar.current.date(byAdding: dateComp, to: meetingTime.endTime!)
            
            meetingTime.timeZone = timeZone
            meeting.meetingTimes.append(meetingTime)
        }
        meeting.timeZones = self.timeZones
        meeting.meetingDurationInMins = Int(self.meetingDuration.text!)!
        return meeting
    }
    
    // Present Time Selection Controller
    @IBAction func selectMeetingTime(_ sender: Any) {
        
        
        let timeZoneDiff = abs(self.timeDiff)
        self.meetingScheduler = self.storyboard?.instantiateViewController(withIdentifier: "viewc") as! ViewController
        self.meetingScheduler.timeDifferenceInSeconds = Float(timeZoneDiff)
        self.meetingScheduler.meeting_title = self.meetingTitle.text!
        self.meetingScheduler.meeting_date = self.meetingDate.text!
        self.meetingScheduler.meetingDuration = Int(self.meetingDuration.text!)!
        
        self.meetingScheduler.meetingData = self.updateMeetingData()
        self.meetingScheduler.meetingDateComps = self.meetingDateComps
        present(self.meetingScheduler, animated: true, completion: nil)
    }
    
    
    @IBAction func addTimeZone(_ sender: Any) {
        let timeZonePicker = TimeZonePickerViewController.getVC(withDelegate: self)
        present(timeZonePicker, animated: true, completion: nil)
    }
    
    @IBAction func backClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setAddTimeZoneButtonStatus() {
        if self.timeZones.count == maxNumTimeZones {
            self.addTimeZoneBtn.isEnabled = false
            self.addTimeZoneBtn.layer.borderColor = UIColor.lightGray.cgColor
            self.doneBtn.isEnabled = true
            self.doneBtn.layer.borderColor = UIColor.blue.cgColor
        } else {
            self.addTimeZoneBtn.isEnabled = true
            self.addTimeZoneBtn.layer.borderColor = UIColor.blue.cgColor
            self.doneBtn.isEnabled = false
            self.doneBtn.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    
}

extension TimePickController: TimeZonePickerDelegate {
    // This function is called once the timezone is selected
    func timeZonePicker(_ timeZonePicker: TimeZonePickerViewController, didSelectTimeZone timeZone: TimeZone) {
        self.timeZones.append(timeZone)
        self.timeZoneCV.reloadData()
        self.setAddTimeZoneButtonStatus()
        self.timeDiff = timeZone.secondsFromGMT() - self.timeDiff
        timeZonePicker.dismiss(animated: true, completion: nil)
    }
    
}

extension UICollectionView {
    
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = UIColor.lightGray
        messageLabel.numberOfLines = 2;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "Helvetica", size: 15)
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel;
    }
    
    func restore() {
        self.backgroundView = nil
    }
}

// MARK -  TimeZone Delegate Protocol
extension TimePickController {
    
    func deleteCell(cell : TimeZoneCell) -> () {
        let selectedIndex = self.timeZoneCV.indexPath(for: cell)?.row
        self.timeZones.remove(at: selectedIndex!)
        self.timeZoneCV.reloadData()
        self.setAddTimeZoneButtonStatus()
    }
    
}

// MARK: TimeZone Collection View
extension TimePickController {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (self.timeZones.count == 0) {
            self.timeZoneCV.setEmptyMessage("Click on \"Add Time Zone\" to Select a Time Zone")
        } else {
            self.timeZoneCV.restore()
        }
        return self.timeZones.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = timeZoneCV.dequeueReusableCell(withReuseIdentifier: "timezoneview", for: indexPath) as! TimeZoneCell
        let tzone = self.timeZones[indexPath.row]
        cell.locationName.text = tzone.identifier
        cell.timeZoneText.text = tzone.abbreviation()!
        cell.contentView.isUserInteractionEnabled = false
        cell.delegate = self
        return cell
    }
    
    
    @objc func editButtonTapped() -> Void {
        print("Hello Edit Button")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15.0
    }

//    CollectionView item selection not needed
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print(indexPath.row)
//    }
}


// MARK: - Initial Setup
extension TimePickController {
    
    func setupTimeZoneCollectionView() {
        timeZoneCV.register(UINib(nibName: "TimeZoneCell", bundle: nil), forCellWithReuseIdentifier: "timezoneview")
        timeZoneCV.dataSource = self
        timeZoneCV.delegate = self
        timeZoneCV.contentInset = UIEdgeInsets(top: 20.0, left: 0, bottom: 20.0, right: 0)
    }
    
    func setupGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(TimePickController.viewTapped(gesture:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    func setupDatePicker() {
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        self.meetingDate.inputView = datePicker
        datePicker!.addTarget(self, action: #selector(TimePickController.dateChanged(datePicker: )), for: .valueChanged)
    }
    
    func setupButtons() {
        let btns : [UIButton] = [self.backBtn,self.addTimeZoneBtn,self.doneBtn]
        for btn in btns {
            btn.layer.borderColor = UIColor.blue.cgColor
            btn.layer.borderWidth = 0.5
            btn.layer.cornerRadius = 4.0
        }
        self.setAddTimeZoneButtonStatus()
    }
}

