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
    
    // MARK: - Properties & IBOutlets
    
    weak var delegate: CountdownSettingsDelegate?
    
    @IBOutlet var countdownUnitSwitches: [UISwitch]!
    
    // MARK: - IBActions
    
    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func countdownUnitsSwitchToggled(_ sender: UISwitch) {
        
        let countdownDisplaySettings = countdownUnitSwitches.map { $0.isOn }
        
        UserDefaults.standard.set(countdownDisplaySettings, forKey: .countdownDisplaySettingsKey)
        delegate?.countdownDisplaySettingsChanged()
    }
        
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViews()
    }
    
    // MARK: - Update Views

    private func updateViews() {
        guard let countdownDisplaySettings = UserDefaults.standard.array(forKey: .countdownDisplaySettingsKey) as? [Bool],
            countdownUnitSwitches.count == countdownDisplaySettings.count else { return }
        
        for i in countdownDisplaySettings.indices {
            countdownUnitSwitches[i].isOn = countdownDisplaySettings[i]
        }
    }
    
}

// MARK: - Extensions

extension String {
    static var countdownDisplaySettingsKey = "CountdownDisplaySettings"
}
