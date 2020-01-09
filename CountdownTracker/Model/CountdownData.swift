//
//  CountdownData.swift
//  CountdownTracker
//
//  Created by David Wright on 12/23/19.
//  Copyright © 2019 Gerardo Hernandez. All rights reserved.
//

import Foundation

class CountdownData: Codable {
    var eventName: String
    var tag: String?
    var eventDate: Date
    var timeIntervalSetting: TimeIntervalSetting
    
    
    init(eventName: String, tag: String? = nil, eventDate: Date, timeIntervalSetting: TimeIntervalSetting? = nil) {
        self.eventName = eventName
        self.tag = tag
        self.eventDate = eventDate
        if let timeIntervalSetting = timeIntervalSetting {
            self.timeIntervalSetting = timeIntervalSetting
        } else {
            self.timeIntervalSetting = TimeIntervalSetting()
        }
    }
}

extension CountdownData: Equatable {
    static func == (lhs: CountdownData, rhs: CountdownData) -> Bool {
        return (lhs.eventName == rhs.eventName) &&
        (lhs.tag == rhs.tag) &&
        (lhs.eventDate == rhs.eventDate) &&
        (lhs.timeIntervalSetting == rhs.timeIntervalSetting)
    }
}

struct TimeIntervalSetting: Codable, Equatable {
    var days: Bool = true
    var hours: Bool = true
    var minutes: Bool = true
    var seconds: Bool = true
    
    static func intervalNames() -> [String] {
        return ["Days", "Hours", "Minutes", "Seconds"]
    }
    
    func getCurrentSettings() -> [Bool] {
        return [days, hours, minutes, seconds]
    }
}

/*
struct TimeIntervalSetting: Codable, Equatable {
    let name: String
    var state: Bool
    
    static func getNames() -> [String] {
        return ["Days", "Hours", "Minutes", "Seconds"]
    }
}
*/

/*
struct TimeIntervalSetting2: Codable, Equatable {
    var days = "Days"
    var hours = "Hours"
    var minutes = "Minutes"
    var seconds = "Seconds"
    
    var currentState: Bool
}
*/
