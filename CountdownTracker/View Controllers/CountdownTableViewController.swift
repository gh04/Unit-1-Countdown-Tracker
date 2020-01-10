//
//  CountdownTableViewController.swift
//  CountdownTracker
//
//  Created by David Wright on 12/19/19.
//  Copyright © 2019 Gerardo Hernandez. All rights reserved.
//

import UIKit

class CountdownTableViewController: UIViewController {

    //MARK: - Properties

    var countdownController = CountdownController()
    lazy var filteredTagNames: [String] = countdownController.tagNames
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - IBActions
    
    @IBAction func sortButtonTapped(_ sender: UIBarButtonItem) {
        
    }
    
    //MARK: - Methods

//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//        self.tableView.reloadData()
//    }
    
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
            filterTableVC.tagNames = countdownController.tagNames
            filterTableVC.filteredTagNames = filteredTagNames
            filterTableVC.delegate = self
            
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
        return countdownController.countdowns.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CountdownCell", for: indexPath) as?
            CountdownTableViewCell else { return UITableViewCell() }
        
        cell.countdown = countdownController.countdowns[indexPath.row]
        
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
//        if let countdownDisplaySettings = UserDefaults.standard.array(forKey: .countdownDisplaySettingsKey) as? [Bool] {
//            print(countdownDisplaySettings)
//        }
        tableView.reloadData()
    }
}

// MARK: - Filter Delegate

extension CountdownTableViewController: FilterDelegate {
    func filterSettingsChanged(filterSettings: [Bool]) {
        
    }
}
