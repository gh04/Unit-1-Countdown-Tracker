//
//  Countdown.swift
//  CountdownTracker
//
//  Created by David Wright on 12/19/19.
//  Copyright © 2019 Gerardo Hernandez. All rights reserved.
//

import Foundation

protocol CountdownDelegate: AnyObject {
    func countdownDidUpdate(timeRemaining: TimeInterval)
    func countdownDidFinish()
}

enum CountdownState {
    case started
    case ended
    case reset
}

class Countdown {
    
    // MARK: - Initializer
    
    init(eventName: String, tag: String? = nil, timeIntervalSetting: TimeIntervalSetting, eventDate: Date) {
        self.countdownData = CountdownData(eventName: eventName, tag: tag, eventDate: eventDate, timeIntervalSetting: timeIntervalSetting)
        self.state = .reset
    }
    
    // MARK: - Properties
    
    var countdownData: CountdownData
    
    private var timer: Timer?
    private var stopDate: Date?
    private(set) var state: CountdownState
    
    weak var delegate: CountdownDelegate?
    
    // MARK: - Computed Properties

    var timeRemaining: TimeInterval {
        if let stopDate = stopDate {
            let timeRemaining = stopDate.timeIntervalSinceNow
            return timeRemaining
        } else {
            return 0
        }
    }
    
    // MARK: - Methods

    func start() {
        cancelTimer()
        timer = Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true, block: updateTimer(timer:))
        stopDate = Date(timeIntervalSinceNow: timeRemaining)
        state = .started
    }
    
    /*
    func reset() {
        stopDate = nil
        cancelTimer()
        state = .reset
    }
    */
    
    func cancelTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func updateTimer(timer: Timer) {
        if let stopDate = stopDate {
            let currentTime = Date()
            if currentTime <= stopDate {
                // Timer is active, keep counting down
                delegate?.countdownDidUpdate(timeRemaining: timeRemaining)
            } else {
                // Timer is finished, reset and stop counting down
                state = .ended
                cancelTimer()
                self.stopDate = nil
                delegate?.countdownDidFinish()
            }
        }
    }
    
}

extension Countdown: Equatable {
        static func == (lhs: Countdown, rhs: Countdown) -> Bool {
            lhs.countdownData == rhs.countdownData
        }
}
