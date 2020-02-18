//
//  TaskRepresentation.swift
//  Tasks
//
//  Created by Gerardo Hernandez on 2/17/20.
//  Copyright © 2020 Gerardo Hernandez. All rights reserved.
//

import Foundation

struct TaskRepresentation: Codable {
    var name: String
    var notes: String?
    var priority: String
    var identifier: String?
}
