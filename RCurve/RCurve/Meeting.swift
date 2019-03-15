//
//  Meeting.swift
//  RCurve
//
//  Created by Sandeep Joshi on 3/10/19.
//  Copyright © 2019 Sandeep Joshi. All rights reserved.
//

import UIKit

class TMeeting {
    
    // Properties
    var meetingDurationInMins : Int = 45
    var timeZones    : [TimeZone] = []
    var meetingTimes : [TMeetingTime] = []
    var meetingDate  : Date? = nil
    
    func isMeetingInPast() -> Bool {
        //TODO: Add Logic to calculate if the date is in past
        return true
    }
    
}

class TMeetingTime {
    var startTime : Date? = nil
    var endTime : Date? = nil
    var timeZone : TimeZone? = nil
}




