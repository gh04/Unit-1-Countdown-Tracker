//
//  TaskController.swift
//  Tasks
//
//  Created by Gerardo Hernandez on 2/17/20.
//  Copyright © 2020 Gerardo Hernandez. All rights reserved.
//

import Foundation
import CoreData

let baseURL = URL(string: "https://tasks-8d69f.firebaseio.com/")!

class TaskController {
    //typealias for autocomplete completionHandler instead of typing the code over and over
    typealias completionHandler = (Error?) -> Void
    
    init() {
        fetchTasksFromServer()
    }
    
    func fetchTasksFromServer(completion: @escaping completionHandler = { _ in }) {
        let requestURL = baseURL.appendingPathExtension("json")
        
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            //if you want it to not to continue. if let, else continues in the code.
            guard error == nil else {
                print("Error fetching tasks: \(error!)")
                DispatchQueue.main.async {
                    completion(error)
                }
                return
            }
            
            guard let data = data else {
                print("No data returned by data task")
                DispatchQueue.main.async {
                    completion(NSError())
                }
                
                return
            }
            
            do {
                //we want the values of the dictionary
                let taskRepresentations = Array(try JSONDecoder().decode([String : TaskRepresentation].self, from: data).values)
                // Update tasks
                try self.updateTasks(with: taskRepresentations)
                DispatchQueue.main.async {
                    completion(nil)
                }
            } catch {
                print("Error decoding task representations: \(error)")
                DispatchQueue.main.async {
                    completion(error)
                }
            }
        }.resume()
    }
    
    func sendTaskToServer(task: Task, completion: @escaping completionHandler = { _ in }) {
        let uuid = task.identifier ?? UUID()
        let requestURL = baseURL.appendingPathComponent(uuid.uuidString).appendingPathExtension("json")
        var request = URLRequest(url: requestURL)
        request.httpMethod = "PUT"
        
        do {
            guard var representation = task.taskRepresentation else {
                completion(NSError())
                return
            }
            representation.identifier = uuid.uuidString
            task.identifier = uuid
            try saveToPersistentStore()
            request.httpBody = try JSONEncoder().encode(representation)
        } catch {
            print("Error encoding task \(task): \(error)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            guard error == nil else {
                print("Error PUTting task to server: \(error!)")
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            DispatchQueue.main.async {
                completion(nil)
            }
        }.resume()
        
    }
    func deleteTaskFromServer(_ task: Task, completion: @escaping completionHandler = { _ in }) {
        guard let uuid = task.identifier else {
            completion(NSError())
            return
        }
        
        let requestURL = baseURL.appendingPathComponent(uuid.uuidString).appendingPathExtension("json")
        var request = URLRequest(url: requestURL)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { (_, _, error) in
            guard error == nil else {
                print("Error deleting task: \(error!)")
                DispatchQueue.main.async {
                    completion(error)
                }
                return
            }
            
            DispatchQueue.main.async {
                completion(nil)
            }
        }.resume()
    }
    
    func updateTasks(with representations: [TaskRepresentation]) throws {
        let tasksWithID = representations.filter { $0.identifier != nil }
        //array of UUIDs. Removes any value that is nil
        let identifiersToFetch = representations.compactMap { UUID(uuidString: $0.identifier!) }
        //creates a dictionary where key is UUID and the value is the task object
        let representationsByID = Dictionary(uniqueKeysWithValues: zip(identifiersToFetch, tasksWithID))
        var tasksToCreate = representationsByID
        
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "identifier IN %@", identifiersToFetch)
        
        let context = CoreDataStack.shared.mainContext
        
        do {
            let existingTasks = try context.fetch(fetchRequest)
            
            for task in existingTasks {
                guard let id = task.identifier,
                    let representation = representationsByID[id] else { continue }
                //from line 88. private func to keep code cleaner. Could have set values here
                self.update(task: task, with: representation)
                tasksToCreate.removeValue(forKey: id)
            }
            for representation in tasksToCreate.values {
                Task(taskRepresentation: representation, context: context)
            }
        } catch {
            print("Error fetching task for UUIDs: \(error)")
            
        }
        try self.saveToPersistentStore()
    }
    
    private func update(task: Task, with representation: TaskRepresentation) {
        task.name = representation.name
        task.notes = representation.notes
        task.priority = representation.priority
    }
    
    private func saveToPersistentStore() throws {
        let moc = CoreDataStack.shared.mainContext
        try moc.save()
    }
}
