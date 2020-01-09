//
//  SettingsTableViewController.swift
//  CountdownTracker
//
//  Created by David Wright on 1/9/20.
//  Copyright © 2020 Gerardo Hernandez. All rights reserved.
//

import UIKit

protocol CountdownSettingsDelegate: class {
    func countdownDisplaySettingsChanged()
}

class SettingsTableViewController: UITableViewController {

    // MARK: - IBOutlets
    
    @IBOutlet var countdownUnitSwitches: [UISwitch]!
    
    
    // MARK: - IBActions
    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func countdownUnitsSwitchToggled(_ sender: UISwitch) {
        let userDefaults = UserDefaults.standard
        
        let countdownDisplaySettings = countdownUnitSwitches.map { $0.isOn }
            
            userDefaults.set(countdownDisplaySettings, forKey: .countdownDisplaySettingsKey)
            delegate?.countdownDisplaySettingsChanged()
        }
        
        weak var delegate: CountdownSettingsDelegate?
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            updateViews()
        }
        
        private func updateViews() {
            let userDefaults = UserDefaults.standard
           
            guard let countdownDisplaySettings = userDefaults.array(forKey: .countdownDisplaySettingsKey) as? [Bool],
                countdownUnitSwitches.count == countdownDisplaySettings.count else { return }
            
            for i in countdownDisplaySettings.indices {
                countdownUnitSwitches[i].isOn = countdownDisplaySettings[i]
            }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension String {
    static var countdownDisplaySettingsKey = "CountdownDisplaySettings"
}
