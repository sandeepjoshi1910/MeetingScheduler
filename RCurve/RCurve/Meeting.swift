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
    var meetingDurationInMins : Int?
    var meetingDict  : [TimeZone:TMeetingTime] = [:]
    var timeZones    : [TimeZone]?
    var meetingDate  : Date?
    func isMeetingInPast() -> Bool {
        //TODO: Add Logic to calculate if the date is in past
        return true
    }
    
}

class TMeetingTime {
    var startTime : MTime = MTime()
    var endTime : MTime = MTime()
}

class MTime {
    var hour : Int = 0
    var minutes : Int = 0
}



