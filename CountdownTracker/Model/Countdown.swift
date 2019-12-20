//
//  Countdown.swift
//  CountdownTracker
//
//  Created by David Wright on 12/19/19.
//  Copyright © 2019 Gerardo Hernandez. All rights reserved.
//

import Foundation

struct Countdown {
    var eventName: String
    var tag: String?
    var time: Date
    
    var timeIntervalSetting: TimeIntervalSetting
}








struct TimeIntervalSetting {
    var days: Bool
    var hours: Bool
    var minutes: Bool
    var seconds: Bool
}
