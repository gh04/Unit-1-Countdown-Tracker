//
//  AddCountdownViewController.swift
//  CountdownTracker
//
//  Created by David Wright on 12/19/19.
//  Copyright © 2019 Gerardo Hernandez. All rights reserved.
//

import UIKit

class CountdownDetailViewController: UIViewController {

    //MARK: Properties

    var countdownController: CountdownController?
    var countdownTableView: UITableView?
    var countdown: Countdown?
    var timeIntervalSetting = TimeIntervalSetting()
    //MARK: - IBOutlets

    @IBOutlet weak var eventNameTextField: UITextField!
    @IBOutlet weak var tagNameTextField: UITextField!
    @IBOutlet weak var eventDatePicker: UIDatePicker!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - IBActions

    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let eventName = eventNameTextField.text,
            !eventName.isEmpty,
            eventDatePicker.date > Date() else { return }
        
        let tag = tagNameTextField.text
        let eventDate = eventDatePicker.date
        
        let newCountdownData = CountdownData(eventName: eventName, tag: tag, eventDate: eventDate, timeIntervalSetting: timeIntervalSetting)
        
        if let countdown = countdown {
            countdownController?.updateCountdown(from: countdown, to: newCountdownData)
        } else {
            countdownController?.createCountdown(with: newCountdownData)
        }
        countdownTableView?.reloadData()
        dismiss(animated: true, completion: nil)
    }
    
    private func getTimeIntervalSettingsFromTableView() -> TimeIntervalSetting {
        return TimeIntervalSetting()
    }
    
    func updateViews() {
        if let countdown = countdown {
            eventNameTextField.text = countdown.eventName
            tagNameTextField.text = countdown.tag
            eventDatePicker.date = countdown.eventDate
            timeIntervalSetting = countdown.timeIntervalSetting
            
            navigationItem.title = "Edit Countdown"
        } else {
            navigationItem.title = "Add Countdown"
        }
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
}

extension CountdownDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TimeIntervalSetting.intervalNames().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TimeIntervalCell", for: indexPath) as?
            TimeIntervalTableViewCell else { return UITableViewCell() }
        
        let timeIntervalName = TimeIntervalSetting.intervalNames()[indexPath.row]
        cell.timeIntervalLabel.text = timeIntervalName
        
        if let timeIntervalSetting = countdown?.timeIntervalSetting.getCurrentSettings()[indexPath.row] {
            cell.timeIntervalSwitch.isOn = timeIntervalSetting
        }
        
        return cell
    }
}

extension CountdownDetailViewController: TimeIntervalTableViewCellDelegate {
    func toggleTimeIntervalSwitch(for cell: TimeIntervalTableViewCell) {
        switch cell.timeIntervalLabel.text {
        case "Days":
            let setting = cell.timeIntervalSwitch.isOn
            if let countdown = countdown {
                countdown.timeIntervalSetting.days = setting
            } else {
                timeIntervalSetting.days = setting
            }
        case "Hours":
            let setting = cell.timeIntervalSwitch.isOn
            if let countdown = countdown {
                countdown.timeIntervalSetting.hours = setting
            } else {
                timeIntervalSetting.hours = setting
            }
        case "Minutes":
            let setting = cell.timeIntervalSwitch.isOn
            if let countdown = countdown {
                countdown.timeIntervalSetting.minutes = setting
            } else {
                timeIntervalSetting.minutes = setting
            }
        case "Seconds":
            let setting = cell.timeIntervalSwitch.isOn
            if let countdown = countdown {
                countdown.timeIntervalSetting.seconds = setting
            } else {
                timeIntervalSetting.seconds = setting
            }
        default:
            break
        }
    }
}
