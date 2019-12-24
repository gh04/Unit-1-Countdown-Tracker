//
//  TimeIntervalTableViewCell.swift
//  CountdownTracker
//
//  Created by David Wright on 12/19/19.
//  Copyright © 2019 Gerardo Hernandez. All rights reserved.
//

import UIKit

protocol TimeIntervalTableViewCellDelegate {
    func toggleTimeIntervalSwitch(for cell: TimeIntervalTableViewCell)
}

class TimeIntervalTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    var timeIntervalSetting: TimeIntervalSetting? {
        didSet {
            updateViews()
        }
    }
    
    var delegate: TimeIntervalTableViewCellDelegate?
    
    //MARK: - IBOutlets

    @IBOutlet weak var timeIntervalLabel: UILabel!
    @IBOutlet weak var timeIntervalSwitch: UISwitch!
    
    //MARK: - IBActions

    @IBAction func timeIntervalSwitchIsToggled(_ sender: UISwitch) {
        delegate?.toggleTimeIntervalSwitch(for: self)
    }
    
    func updateViews() {
        guard let timeIntervalSetting = timeIntervalSetting else { return }
        
        timeIntervalLabel.text = timeIntervalSetting.name
        timeIntervalSwitch.isOn = timeIntervalSetting.state
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
