//
//  CountdownTableViewController.swift
//  CountdownTracker
//
//  Created by David Wright on 12/19/19.
//  Copyright © 2019 Gerardo Hernandez. All rights reserved.
//

import UIKit

class CountdownTableViewController: UIViewController {

    //MARK: - Properties & IBOutlets

    var countdownController = CountdownController()
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - IBActions
    
    @IBAction func sortButtonTapped(_ sender: UIBarButtonItem) {
        showSortMenu()
    }
    
    //MARK: - Sort Menu

    private func showSortMenu() {
        let sortMenu = UIAlertController(title: "Sort Countdowns", message: nil, preferredStyle: .actionSheet)
        
        let sortOptions: [(title: String, sortStyle: SortStyle)] = [
            ("Time Remaining ↓", .time_minToMax),
            ("Time Remaining ↑", .time_maxToMin),
            ("Tag Name AZ↓", .tagName_AToZ),
            ("Tag Name ZA↓", .tagName_ZToA),
            ("Event Name AZ↓", .eventName_AToZ),
            ("Event Name ZA↓", .eventName_ZToA)]
        
        for sortOption in sortOptions {
            if sortOption.sortStyle == countdownController.sortStyle {
                let currentSortStyleTitle = "                " + sortOption.title + "          ✔️"
                sortMenu.addAction(UIAlertAction(title: currentSortStyleTitle, style: .default, handler: nil))
            } else {
            sortMenu.addAction(UIAlertAction(title: sortOption.title, style: .default, handler: { action in
                self.setCurrentSortStyle(to: sortOption.sortStyle) }))
            }
        }
        
        sortMenu.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(sortMenu, animated: true, completion: nil)
    }
    
    func setCurrentSortStyle(to sortStyle: SortStyle) {
        countdownController.sortStyle = sortStyle
        tableView.reloadData()
    }
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countdownController.loadFromPersistentStore()
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case "AddCountdownSegue":
            guard let countdownDetailVC = segue.destination as? CountdownDetailViewController else { return }
            countdownDetailVC.countdownController = countdownController
            countdownDetailVC.countdownTableView = tableView
            
        case "EditCountdownSegue":
            guard let countdownDetailVC = segue.destination as? CountdownDetailViewController,
                let cell = sender as? CountdownTableViewCell else { return }
            countdownDetailVC.countdownController = countdownController
            countdownDetailVC.countdownTableView = tableView
            countdownDetailVC.countdown = cell.countdown

        case "FilterSegue":
            guard let filterTableVC = segue.destination as? FilterTableViewController else { return }
            filterTableVC.delegate = self
            filterTableVC.countdownController = countdownController

        case "SettingsSegue":
            guard let SettingsTableVC = segue.destination as? SettingsTableViewController else { return }
            SettingsTableVC.delegate = self
            
        default:
            return
        }
    }
}

// MARK: - Data Source

extension CountdownTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countdownController.displayedCountdowns.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CountdownCell", for: indexPath) as? CountdownTableViewCell else { return UITableViewCell() }
        
        cell.countdown = countdownController.displayedCountdowns[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let cell = tableView.cellForRow(at: indexPath) as? CountdownTableViewCell,
            let countdownData = cell.countdown else { return }
            
            countdownController.deleteCountdown(with: countdownData)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

// MARK: - Settings Delegate

extension CountdownTableViewController: CountdownSettingsDelegate {
    func countdownDisplaySettingsChanged() {
        tableView.reloadData()
    }
}

// MARK: - Filter Delegate

extension CountdownTableViewController: FilterTableViewDelegate {
    func filterSettingsChanged() {
        tableView.reloadData()
    }
}
