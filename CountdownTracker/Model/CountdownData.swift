//
//  CountdownData.swift
//  CountdownTracker
//
//  Created by David Wright on 12/23/19.
//  Copyright © 2019 Gerardo Hernandez. All rights reserved.
//

import Foundation

struct CountdownData: Codable, Equatable {
    var eventName: String
    var tag: String?
    var eventDate: Date
    var timeIntervalSetting: TimeIntervalSetting
}

struct TimeIntervalSetting: Codable, Equatable {
    var days: Bool
    var hours: Bool
    var minutes: Bool
    var seconds: Bool
}
