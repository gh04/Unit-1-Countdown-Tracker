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
    
    var sections: [SectionTypes] {
        var result = [SectionTypes.filter]
        guard let cc = countdownController else { return result }
        if cc.hasCountdownsWithNoTag {
            result.append(.noTag)
        }
        if cc.hasCountdownsWithCustomTag {
            result.append(.customTag)
        }
        return result
    }
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - IBActions

    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        guard let cc = countdownController else { return }
//        if cc.hasCountdownsWithNoTag {
//            sections.append(.noTag)
//        }
//        if cc.hasCountdownsWithCustomTag {
//            sections.append(.customTag)
//        }
    }
    
}

//MARK: - Data Source

extension FilterTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sections[section] {
        case .filter, .noTag:
            return 1
        case .customTag:
            guard let customTagNames = countdownController?.customTagNames else { return 0 }
            return customTagNames.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FilterCell", for: indexPath) as? FilterTableViewCell,
        let cc = countdownController else { return UITableViewCell() }
        
        cell.delegate = self
        
        switch sections[indexPath.section] {
        case .filter:
            cell.tagNameLabel.text = "Filter"
            cell.filterSwitch.isOn = cc.filterIsOn
        case .noTag:
            cell.tagNameLabel.text = "No tag"
            cell.filterSwitch.isOn = cc.noTagFilterIsOn
            cell.filterSwitch.isEnabled = cc.filterIsOn
        case .customTag:
            let tagName = cc.customTagNames[indexPath.row]
            cell.tagNameLabel.text = tagName
            cell.filterSwitch.isOn = cc.filteredTagNames.contains(tagName)
            cell.filterSwitch.isEnabled = cc.filterIsOn
        }

        return cell
    }
    
    //MARK: - Section Header

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        switch sections[section] {
        case .filter:
            return createViewForSectionHeader()
        case .noTag:
            return createViewForSectionHeader(withText: "DEFAULT")
        case .customTag:
            return createViewForSectionHeader(withText: "CUSTOM TAGS")
        }
    }
    
    func createViewForSectionHeader(withText text: String? = nil) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 30))
        view.backgroundColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1)
        
        guard let headerText = text else { return view }
        
        let label = UILabel(frame: CGRect(x: 16, y: 0, width: view.frame.width - 32, height: 30))
        label.text = headerText
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        view.addSubview(label)
        
        return view
    }
    
    //MARK: - Section Footer

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        switch sections[section] {
        case .filter:
            let footerText = "When Filter is On, only countdowns with the selected tags will be displayed."
            return createViewForSectionFooter(withText: footerText)
        case .noTag, .customTag:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch sections[section] {
        case .filter:
            return 44
        case .noTag, .customTag:
            return 0
        }
    }
    
    func createViewForSectionFooter(withText text: String) -> UIView {
        let label = UILabel(frame: CGRect(x: 16, y: 8, width: tableView.frame.width - 32, height: 30))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.text = text
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.sizeToFit()

        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: label.frame.height + 16))
        view.backgroundColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1)
        view.addSubview(label)
        
        return view
    }
    
}

//MARK: - Filter Cell Delegate

extension FilterTableViewController: FilterTableViewCellDelegate {
    
    func toggledFilterSwitch(for cell: FilterTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell),
        let cc = countdownController else { return }
        
        switch sections[indexPath.section] {
        case .filter:
            cc.filterIsOn.toggle()
        case .noTag:
            cc.noTagFilterIsOn.toggle()
        case .customTag:
            let updatedTagName = cc.customTagNames[indexPath.row]
            let filteredTagNames = cc.filteredTagNames
            
            if filteredTagNames.contains(updatedTagName) {
                guard let filteredIndex = filteredTagNames.firstIndex(of: updatedTagName) else { return }
                cc.filteredTagNames.remove(at: filteredIndex)
            } else {
                cc.filteredTagNames.append(updatedTagName)
            }
        }
        
        delegate?.filterSettingsChanged()
        tableView.reloadData()
    }
}

// MARK: - Extensions

extension String {
    static var countdownFilterSettingsKey = "CountdownFilterSettings"
}
