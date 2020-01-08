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
    var timeIntervalSetting: [TimeIntervalSetting]
    
    
    init(eventName: String, tag: String? = nil, eventDate: Date, timeIntervalSetting: [TimeIntervalSetting]? = nil) {
        self.eventName = eventName
        self.tag = tag
        self.eventDate = eventDate
        if let timeIntervalSetting = timeIntervalSetting {
            self.timeIntervalSetting = timeIntervalSetting
        } else {
            var temp: [TimeIntervalSetting] = []
            for name in TimeIntervalSetting.getNames() {
                temp.append(TimeIntervalSetting(name: name, state: true))
            }
            self.timeIntervalSetting = temp
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

/*
struct TimeIntervalSetting: Codable, Equatable {
    var days: Bool
    var hours: Bool
    var minutes: Bool
    var seconds: Bool
    
    static func intervalNames() -> [String] {
        return ["Days", "Hours", "Minutes", "Seconds"]
    }
    
    func getStates() -> [Bool] {
        return [days, hours, minutes, seconds]
    }
}
*/

struct TimeIntervalSetting: Codable, Equatable {
    let name: String
    var state: Bool
    
    static func getNames() -> [String] {
        return ["Days", "Hours", "Minutes", "Seconds"]
    }
}

/*
struct TimeIntervalSetting2: Codable, Equatable {
    var days = "Days"
    var hours = "Hours"
    var minutes = "Minutes"
    var seconds = "Seconds"
    
    var currentState: Bool
}
*/
