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
        let timeIntervalSetting = [TimeIntervalSetting(name: "Days", state: true)]
        
        let newCountdownData = CountdownData(eventName: eventName, tag: tag, eventDate: eventDate, timeIntervalSetting: timeIntervalSetting)
        
        if let countdown = countdown {
            countdownController?.updateCountdown(from: countdown, to: newCountdownData)
        } else {
            countdownController?.createCountdown(with: newCountdownData)
        }
        countdownTableView?.reloadData()
        dismiss(animated: true, completion: nil)
    }
    
    func updateViews() {
        if let countdown = countdown {
            eventNameTextField.text = countdown.eventName
            tagNameTextField.text = countdown.tag
            eventDatePicker.date = countdown.eventDate
            
            navigationItem.title = "Edit Countdown"
        } else {
            navigationItem.title = "Add Countdown"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
}

extension CountdownDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TimeIntervalSetting.getNames().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TimeIntervalCell", for: indexPath) as?
            TimeIntervalTableViewCell,
        let timeIntervalSetting = countdown?.timeIntervalSetting[indexPath.row] else { return UITableViewCell() }
        
        //cell.timeIntervalLabel.text = TimeIntervalSetting.intervalNames()[indexPath.row]
        //cell.timeIntervalSwitch.isOn = state
        cell.timeIntervalSetting = timeIntervalSetting
        
        return cell
    }
}

extension CountdownTableViewController: TimeIntervalTableViewCellDelegate {
    func toggleTimeIntervalSwitch(for cell: TimeIntervalTableViewCell) {
        
    }
}
