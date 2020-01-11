//
//  FilterViewController.swift
//  CountdownTracker
//
//  Created by David Wright on 12/19/19.
//  Copyright © 2019 Gerardo Hernandez. All rights reserved.
//

import UIKit

protocol FilterTableViewDelegate {
    func filterSettingsChanged()
}

enum SectionTypes {
    case filter
    case noTag
    case customTag
}

class FilterTableViewController: UIViewController {
    
    //MARK: - Properties
    
    var delegate: FilterTableViewDelegate?
    
    var countdownController: CountdownController?
        
    var filteredTagNames: [String] = []
        
    var sections: [SectionTypes] = [.filter]
    
//    var tagFilterSettings: [Bool] {
//        return tagNames.map { filteredTagNames.contains($0) }
//    }
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - IBActions

    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let countdownController = countdownController else { return }
        if !countdownController.countdownsWithNoTag.isEmpty {
            sections.append(.noTag)
        }
        if !countdownController.countdownsWithCustomTag.isEmpty {
            sections.append(.customTag)
        }
    }
    
}

//MARK: - Data Source

extension FilterTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        switch sections[section] {
//        case .filter, .noTag:
//            return nil
//        case .customTag:
//            return "Custom Tags"
//        }
//    }
//
//    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
//        switch sections[section] {
//        case .filter:
//            return "Turn on filter to display only the countdowns with tags selected below"
//        case .noTag, .customTag:
//            return nil
//        }
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sections[section] {
        case .filter, .noTag:
            return 1
        case .customTag:
            guard let customTagNames = countdownController?.tagNames else { return 0 }
            return customTagNames.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FilterCell", for: indexPath) as?
            FilterTableViewCell,
        let countdownController = countdownController else { return UITableViewCell() }
        
        cell.delegate = self
        
        switch sections[indexPath.section] {
        case .filter:
            cell.tagNameLabel.text = "Filter"
            cell.filterSwitch.isOn = countdownController.filterIsOn
        case .noTag:
            cell.tagNameLabel.text = "No Tag"
            cell.filterSwitch.isOn = countdownController.noTagFilterIsOn
            cell.filterSwitch.isEnabled = countdownController.filterIsOn
        case .customTag:
            let tagName = countdownController.tagNames[indexPath.row]
            cell.tagNameLabel.text = tagName
            cell.filterSwitch.isOn = countdownController.filteredTagNames.contains(tagName)
            cell.filterSwitch.isEnabled = countdownController.filterIsOn
        }

        return cell
    }
}



extension FilterTableViewController: FilterTableViewCellDelegate {
    
    func toggledFilterSwitch(for cell: FilterTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell),
        let countdownController = countdownController else { return }
        
        switch sections[indexPath.section] {
        case .filter:
            countdownController.filterIsOn.toggle()
        case .noTag:
            countdownController.noTagFilterIsOn.toggle()
        case .customTag:
            let updatedTagName = countdownController.tagNames[indexPath.row]
            let filteredTagNames = countdownController.filteredTagNames
            
            if filteredTagNames.contains(updatedTagName) {
                guard let filteredIndex = filteredTagNames.firstIndex(of: updatedTagName) else { return }
                countdownController.filteredTagNames.remove(at: filteredIndex)
            } else {
                countdownController.filteredTagNames.append(updatedTagName)
            }
        }
        
        delegate?.filterSettingsChanged()
        tableView.reloadData()
    }
}
