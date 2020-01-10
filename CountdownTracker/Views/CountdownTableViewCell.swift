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
        didSet {
            updateViews()
        }
    }
    
    var dateFormatter: DateComponentsFormatter {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .short
                
        if let countdownDisplaySettings = UserDefaults.standard.array(forKey: .countdownDisplaySettingsKey) as? [Bool] {
            //MARK: TODO: Update Units
            let units: [NSCalendar.Unit] = [.day, .hour, .minute, .second]
            var allowedUnits: NSCalendar.Unit = []
            
            for i in units.indices where countdownDisplaySettings[i] {
                allowedUnits.insert(units[i])
            }
            
            formatter.allowedUnits = allowedUnits
            
        } else {
            formatter.allowedUnits = [.day, .hour, .minute, .second]
        }
        
        return formatter
    }
    
    //MARK: - Methods
    
    func updateViews() {
        guard let countdown = countdown else { return }
        
        countdown.delegate = self
        eventNameLabel.text = countdown.eventName
        tagLabel.text = countdown.tag
        
        if countdown.state == .started {
            countdownTimeLabel.text = dateFormatter.string(from: countdown.timeRemaining)
        } else {
            countdownTimeLabel.text = dateFormatter.string(from: 0)
        }
    }
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }

    /*
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    */

}

//MARK: - Countdown Delegate

extension CountdownTableViewCell: CountdownDelegate {
    func countdownDidUpdate(timeRemaining: TimeInterval) {
        updateViews()
    }
    
    func countdownDidFinish() {
        updateViews()
        showAlert()
    }
    
    //MARK: TODO: Implement Alert
    func showAlert() {
        
    }
}
