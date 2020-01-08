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
    
    var dateFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .short
        formatter.allowedUnits = [.day, .hour, .minute, .second]
        return formatter
    }()
    
    var countdown: Countdown? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let countdown = countdown else { return }
        
        eventNameLabel.text = countdown.eventName
        tagLabel.text = countdown.tag
        countdownTimeLabel.text = dateFormatter.string(from: countdown.timeRemaining)
        print(countdownTimeLabel.text ?? "nil")
    }
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
