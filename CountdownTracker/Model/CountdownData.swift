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
    var tag: String
    var eventDate: Date
    
    init(eventName: String, tag: String, eventDate: Date) {
        self.eventName = eventName
        self.tag = tag
        self.eventDate = eventDate
    }
}

extension CountdownData: Equatable {
    static func == (lhs: CountdownData, rhs: CountdownData) -> Bool {
        return (lhs.eventName == rhs.eventName) &&
        (lhs.tag == rhs.tag) &&
        (lhs.eventDate == rhs.eventDate)
    }
}
