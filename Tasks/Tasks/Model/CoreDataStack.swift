//
//  CoreDataStack.swift
//  Tasks
//
//  Created by Gerardo Hernandez on 2/11/20.
//  Copyright © 2020 Gerardo Hernandez. All rights reserved.
//

import Foundation
import CoreData
//created all four layers of Core Data Stack
//singleton object in project that is referenced throughout
class CoreDataStack {
    // can be used globally. There is only one is CoreDataStack
    //try not to have too many static var
    static let shared = CoreDataStack()
    //not going to run this code until we ask for container. When the value is actually needed.
    private init() {}
    //persistent store
    //computes the first time then loads after the next load
   lazy var container: NSPersistentContainer = {
        let newContainer = NSPersistentContainer(name: "Tasks")
        newContainer.loadPersistentStores { (_, error) in
            if let error = error {
                //may not want to have a fatal error in production. Good to know you don't have Core Data, though.
                fatalError("Failed to laod persistent stores: \(error)")
            }
        }
        return newContainer
    }()
    
    var mainContext: NSManagedObjectContext {
        return container.viewContext
    }
}
