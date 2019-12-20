//
//  FilterTableViewCell.swift
//  CountdownTracker
//
//  Created by David Wright on 12/19/19.
//  Copyright © 2019 Gerardo Hernandez. All rights reserved.
//

import UIKit

class FilterTableViewCell: UITableViewCell {

    //MARK: - IBOutlets

    @IBOutlet weak var tagNameLabel: UILabel!
    
    //MARK: - IBActions

    @IBAction func filterSwitchIsToggled(_ sender: UISwitch) {
        
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
