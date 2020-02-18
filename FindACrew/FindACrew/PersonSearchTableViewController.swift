//
//  PersonSearchTableViewController.swift
//  FindACrew
//
//  Created by Gerardo Hernandez on 1/16/20.
//  Copyright © 2020 Gerardo Hernandez. All rights reserved.
//

import UIKit

class PersonSearchTableViewController: UITableViewController {
//dont need to creat an outlet for TableView since it is already a TableViewController. if it was only a View controller with a TableView you would neeed to create a TableViewOutlet
    // MARK: - Properties
    private let personController = PersonController()
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Public Methods
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return personController.people.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //another good reason to force unwrap because we need it to happen. if it fails here why know why
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell", for: indexPath) as! PersonTableViewCell
        
        guard indexPath.row < personController.people.count else { return cell }
        let person = personController.people[indexPath.row]
       //you want to set the labels in the PersonTableViewCell updateViews. Not here. set the cell to its model
        cell.person = person
       

        return cell
    }
   
}

extension PersonSearchTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        
        // so we know it is running
        print("Searching for \(searchTerm)..")
        
        //using shortform closures. delete the closure

        personController.searchForPeopleWith(searchTerm: searchTerm) {
        //go back to the main queue.
            DispatchQueue.main.async {            
                //so we know it is working
                print("Found \(self.personController.people.count) results!")
                self.tableView.reloadData()
            }
            
        }
    }
}
