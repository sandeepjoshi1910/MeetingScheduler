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

class TimePickController: UIViewController {

    var timeDiff = 0
    var meetingScheduler : ViewController = ViewController()
    
    @IBOutlet weak var loclabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString("1021 S Racine Ave. Chicago") { (placemarks, error) in
            let placemark = placemarks?.first
            let lat = placemark?.location?.coordinate.latitude
            let lon = placemark?.location?.coordinate.longitude
            print("The lattitude : \(String(describing: lat)) and Longitude \(String(describing: lon))")
            self.loclabel.text = "The lattitude : \(lat!) and Longitude \(lon!)"
            let location = CLLocation(latitude: lat!, longitude: lon!)
            self.loclabel.text = "\(location.timestamp)"
        }
        
        
        
        // Do any additional setup after loading the view.
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TimePickController: TimeZonePickerDelegate {
    
    func timeZonePicker(_ timeZonePicker: TimeZonePickerViewController, didSelectTimeZone timeZone: TimeZone) {
        self.loclabel.text = "\(timeZone.identifier) \(timeZone.abbreviation()!)"
//        timeZoneOffset.text = timeZone.abbreviation()
        self.timeDiff = timeZone.secondsFromGMT() - self.timeDiff
        timeZonePicker.dismiss(animated: true, completion: nil)
    }
    
}
