//
//  FilterViewController.swift
//  CountdownTracker
//
//  Created by David Wright on 12/19/19.
//  Copyright © 2019 Gerardo Hernandez. All rights reserved.
//

import UIKit

protocol FilterDelegate {
    func filterSettingsChanged(filterSettings: [Bool])
}

class FilterTableViewController: UIViewController {
    
    //MARK: - Properties

    var delegate: FilterDelegate?
    
    var tagNames: [String] = []
    
    var filteredTagNames: [String] = []
    
    var tagFilterSettings: [Bool] {
        return tagNames.map { filteredTagNames.contains($0) }
    }
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - IBActions

    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
    
}

//MARK: - Data Source

extension FilterTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tagNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FilterCell", for: indexPath) as?
            FilterTableViewCell else { return UITableViewCell() }
        
        cell.tagNameLabel.text = tagNames[indexPath.row]
        cell.filterSwitch.isOn = tagFilterSettings[indexPath.row]
        
        return cell
    }
}



extension FilterTableViewController: FilterTableViewCellDelegate {
    
    func toggledFilterSwitch(for cell: FilterTableViewCell) {
        guard let updatedTagIndex = tableView.indexPath(for: cell)?.row else { return }
        
        let updatedTagName = tagNames[updatedTagIndex]
        
        if filteredTagNames.contains(updatedTagName) {
            guard let filteredIndex = filteredTagNames.firstIndex(of: updatedTagName) else { return }
            filteredTagNames.remove(at: filteredIndex)
        } else {
            filteredTagNames.append(updatedTagName)
        }
        
        tableView.reloadData()
    }
}
