//
//  TaskDetailViewController.swift
//  Tasks
//
//  Created by Gerardo Hernandez on 2/11/20.
//  Copyright © 2020 Gerardo Hernandez. All rights reserved.
//

import UIKit
//Can also re-name files while refractoring 
class TaskDetailViewController: UIViewController {
    
    var taskController: TaskController!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var priorityControl: UISegmentedControl!
    
    
    
    //injecting a dependcy
    var task: Task? {
        didSet {
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    @IBAction func saveTask(_ sender: UIBarButtonItem) {
        guard let name = nameTextField.text,
            //not name isEmpty
            !name.isEmpty else {return}
        let notes = notesTextView.text
        let priorityIndex = priorityControl.selectedSegmentIndex
        let priority = TaskPriority.allPriorities[priorityIndex]
        
        if let task = task {
            //editing exising task
            task.name = name
            task.notes = notes
            task.priority = priority.rawValue
            taskController.sendTaskToServer(task: task)
        } else {
            //convinience init
            //create new task
            //managed objects - have invisible strings connecting them to the Core Data.
            //suppressing warning by let _ . When it was here. Got rid of it by @discarable result
           let task = Task(name: name, notes: notes, priority: priority)
            taskController.sendTaskToServer(task: task)
        }
        //saving it to disk. If we did not call save() Core Data would not not update.
        do {
            //managed object context
            let moc = CoreDataStack.shared.mainContext
            try moc.save()
        } catch {
            print("Error saving task: \(error)")
        }
        //pop to TableView
        navigationController?.popViewController(animated: true)
    }
    //make sure you use updateViews
    private func updateViews() {
        //checking whether its true. don't have to use let
        guard isViewLoaded else { return }
        
        title = task?.name ?? "Create Task"
        nameTextField.text = task?.name
        notesTextView.text = task?.notes
        
        let priority: TaskPriority
        if let taskPriority = task?.priority {
            priority = TaskPriority(rawValue: taskPriority)!
        } else {
            priority = .normal
        }
        priorityControl.selectedSegmentIndex = TaskPriority.allPriorities.firstIndex(of: priority) ?? 1
    }
    
}

