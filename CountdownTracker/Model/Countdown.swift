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
    func countdownDidFinish(for eventName: String)
}

enum CountdownState {
    case notStarted
    case started
    case ended
}

class Countdown: CountdownData {
    
    // MARK: - Initializer
    
    init(with countdownData: CountdownData) {
        super.init(eventName: countdownData.eventName, tag: countdownData.tag, eventDate: countdownData.eventDate)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    // MARK: - Properties
        
    private var timer: Timer?
    private(set) var state: CountdownState = .notStarted
    weak var delegate: CountdownDelegate?
    
    // MARK: - Computed Properties

    var timeRemaining: TimeInterval {
        let currentTime = Date()
        if currentTime <= eventDate {
            return eventDate.timeIntervalSinceNow
        } else {
            return 0
        }
    }
    
    // MARK: - Methods

    func start() {
        cancelTimer()
        timer = Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true, block: updateTimer(timer:))
        state = .started
    }
    
    func cancelTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func updateTimer(timer: Timer) {
        let currentTime = Date()
        if currentTime <= eventDate {
            // Timer is active, keep counting down
            delegate?.countdownDidUpdate(timeRemaining: timeRemaining)
        } else {
            // Timer is finished, reset and stop counting down
            state = .ended
            cancelTimer()
            delegate?.countdownDidFinish(for: eventName)
        }
    }
    
}
