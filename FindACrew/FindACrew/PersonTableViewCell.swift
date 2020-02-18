//
//  PersonTableViewCell.swift
//  FindACrew
//
//  Created by Gerardo Hernandez on 1/16/20.
//  Copyright © 2020 Gerardo Hernandez. All rights reserved.
//

import UIKit

class PersonTableViewCell: UITableViewCell {
//Don't need an outlet from the
   // MARK: - Properties
    var person: Person? {
        didSet {
            //call before you make the func
            updateViews()
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var birthYearLabel: UILabel!
    
    // MARK: - Private Methods
    
    private func updateViews() {
        guard let person = person else { return }
        
        nameLabel.text = person.name
        genderLabel.text = "Gender \(person.gender)"
        birthYearLabel.text = "Birth year: \(person.birthYear)"
    }
    
}
