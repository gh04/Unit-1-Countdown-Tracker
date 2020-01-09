//
//  AddCountdownViewController.swift
//  CountdownTracker
//
//  Created by David Wright on 12/19/19.
//  Copyright © 2019 Gerardo Hernandez. All rights reserved.
//

import UIKit

class CountdownDetailViewController: UIViewController {

    //MARK: - Properties

    var countdownController: CountdownController?
    var countdownTableView: UITableView?
    var countdown: Countdown?
    
    //MARK: - IBOutlets

    @IBOutlet weak var eventNameTextField: UITextField!
    @IBOutlet weak var tagNameTextField: UITextField!
    @IBOutlet weak var eventDatePicker: UIDatePicker!
    
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
        let newCountdownData = CountdownData(eventName: eventName, tag: tag, eventDate: eventDate)
        
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
            navigationItem.title = "Edit Countdown"
            eventNameTextField.text = countdown.eventName
            tagNameTextField.text = countdown.tag
            eventDatePicker.date = countdown.eventDate
        } else {
            navigationItem.title = "Add Countdown"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
}
