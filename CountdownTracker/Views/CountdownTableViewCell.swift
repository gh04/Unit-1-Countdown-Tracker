//
//  CountdownTableViewCell.swift
//  CountdownTracker
//
//  Created by David Wright on 12/19/19.
//  Copyright © 2019 Gerardo Hernandez. All rights reserved.
//

import UIKit

class CountdownTableViewCell: UITableViewCell {

    //MARK: - IBOutlets
    
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var countdownTimeLabel: UILabel!
    
    //MARK: - Properties
    
    var countdown: Countdown? {
        didSet { updateViews() }
    }
    
    var dateFormatter: DateComponentsFormatter {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.zeroFormattingBehavior = .pad
        formatter.allowedUnits = getAllowedUnits()
        
        return formatter
    }
    
    //MARK: - Methods
    
    func getAllowedUnits() -> NSCalendar.Unit {
        guard let countdownDisplaySettings = UserDefaults.standard.array(forKey: .countdownDisplaySettingsKey) as? [Bool] else { return [.day, .hour, .minute, .second] }
        
        let units: [NSCalendar.Unit] = [.day, .hour, .minute, .second]
        var allowedUnits: NSCalendar.Unit = []
        
        for i in units.indices where countdownDisplaySettings[i] {
            allowedUnits.insert(units[i])
        }
        
        return allowedUnits
    }
    
    func updateViews() {
        guard let countdown = countdown else { return }
        
        countdown.delegate = self
        eventNameLabel.text = countdown.eventName
        tagLabel.text = countdown.tag
        
        //countdownTimeLabel.font = UIFont.monospacedSystemFont(ofSize: countdownTimeLabel.font.pointSize, weight: .semibold)
        
        if countdown.state == .started {
            countdownTimeLabel.text = dateFormatter.string(from: countdown.timeRemaining)
        } else {
            countdownTimeLabel.text = dateFormatter.string(from: 0)
        }
    }
}

// MARK: - Timer Delegate

extension CountdownTableViewCell: CountdownDelegate {
    func countdownDidFinish(for eventName: String) {
        updateViews()
    }

    func countdownDidUpdate(timeRemaining: TimeInterval) {
        updateViews()
    }
}
