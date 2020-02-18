//
//  Person.swift
//  FindACrew
//
//  Created by Gerardo Hernandez on 1/16/20.
//  Copyright © 2020 Gerardo Hernandez. All rights reserved.
//

import Foundation


struct PersonSearch: Codable {
    let results: [Person]
}

//most basic model we can create in program
//structs are good to use or class. they immutable
//will only decode only with struct variables are the same are JSON

struct Person: Codable {
    let name: String
    let gender: String
    //is not the same as JSON
    let birthYear: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case gender
        case birthYear = "birth_year"
    }
}


