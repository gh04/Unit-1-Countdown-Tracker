//
//  FilterTableViewCell.swift
//  CountdownTracker
//
//  Created by David Wright on 12/19/19.
//  Copyright © 2019 Gerardo Hernandez. All rights reserved.
//

import UIKit

protocol FilterTableViewCellDelegate {
    func toggledFilterSwitch(for cell: FilterTableViewCell)
}

class FilterTableViewCell: UITableViewCell {

    //MARK: - Properties
    
    var delegate: FilterTableViewCellDelegate?
    
    //MARK: - IBOutlets

    @IBOutlet weak var tagNameLabel: UILabel!
    @IBOutlet weak var filterSwitch: UISwitch!
    
    //MARK: - IBActions

    @IBAction func filterSwitchIsToggled(_ sender: UISwitch) {
        delegate?.toggledFilterSwitch(for: self)
    }
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
