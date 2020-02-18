//
//  TasksTableViewController.swift
//  Tasks
//
//  Created by Gerardo Hernandez on 2/11/20.
//  Copyright © 2020 Gerardo Hernandez. All rights reserved.
//

import UIKit
import CoreData

class TasksTableViewController: UITableViewController {
    
    private let taskController = TaskController()
    
    lazy var fetchedResultsController: NSFetchedResultsController<Task> = {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        fetchRequest.sortDescriptors = [
            //key is a name of an attribute we are fetching
            //starting to a-z = true.. z-a = false
            NSSortDescriptor(key: "priority", ascending: true),
            NSSortDescriptor(key: "name", ascending: true)
        ]
        let moc = CoreDataStack.shared.mainContext
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest,
                                             managedObjectContext: moc,
                                             sectionNameKeyPath: "priority",
                                             cacheName: nil)
        frc.delegate = self
        //throws. a shortcut from the do-try-catch
        try! frc.performFetch()
        return frc
    }()//execute what is in here
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //for the data to appear in the table view
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    @IBAction func refresh(_ sender: Any) {
        taskController.fetchTasksFromServer { (_) in
            self.refreshControl?.endRefreshing()
        }
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    //section headers
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionInfo = fetchedResultsController.sections?[section]
        return sectionInfo?.name.capitalized
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
        
        let task = fetchedResultsController.object(at: indexPath)
        cell.textLabel?.text = task.name
        
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            //fetch getting called again. Very enfficient 
            let task = fetchedResultsController.object(at: indexPath)
            
            taskController.deleteTaskFromServer(task) { (error) in
                guard error == nil else {
                    print("Error deleting task from server: \(error!)")
                    return
                }
                
                let moc = CoreDataStack.shared.mainContext
                moc.delete(task)
                do {
                    try moc.save()
                } catch {
                    moc.reset()
                    print("Error saving managed object context: \(error)")
                }
            }
            
        }    
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    //pass in the Task to the detailVC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowTaskDetailSegue" {
            guard let detailVC = segue.destination as? TaskDetailViewController  else { return }
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            detailVC.task = fetchedResultsController.object(at: indexPath)
        }
        
        if let detailVC = segue.destination as? TaskDetailViewController {
            detailVC.taskController = taskController
        }
    }
}
//use this code anytime you have a table view
extension TasksTableViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        //we are going to change the data
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    //sections change. insert, update,
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex),  with: .automatic)
        case .delete:
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .automatic)
        default:
            break
        }
    }
    //legacy code objc
    //optionals becuase optionals came move
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            guard let newIndexPath = newIndexPath else { return }
            //.automatic animations
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .update:
            guard let indexPath = indexPath else { return }
            tableView.reloadRows(at: [indexPath], with: .automatic)
        case .move:
            guard let oldIndexPath = indexPath,
                let newIndexPath = newIndexPath else { return }
            //delete in old indexpath and insert in new indexpath
            tableView.deleteRows(at: [oldIndexPath], with: .automatic)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .delete:
            guard let indexPath = indexPath else { return }
            tableView.deleteRows(at: [indexPath], with: .automatic)
        @unknown default:
            break
        }
    }
}
