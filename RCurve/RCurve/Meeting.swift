//
//  Meeting.swift
//  RCurve
//
//  Created by Sandeep Joshi on 3/10/19.
//  Copyright © 2019 Sandeep Joshi. All rights reserved.
//

import UIKit

class Meeting {
    
    // Properties
    var meetingDurationInMins : Int?
    var meetingTimes : [MeetingTime]? = []
    
    
    func isMeetingInPast() -> Bool {
        //TODO: Add Logic to calculate if the date is in past
        return true
    }
    
}

class MeetingTime {
    var startTime : Date?
    var endTime : Date?
    var timeZone : TimeZone?
}


