//
//  PersonController.swift
//  FindACrew
//
//  Created by Gerardo Hernandez on 1/16/20.
//  Copyright © 2020 Gerardo Hernandez. All rights reserved.
//

import Foundation

class PersonController {
    // MARK: - Properties
    
    //for unwrap because it has to be right or it won't work. Find out now and not later
    private let baseURL = URL(string: "https://swapi.co/api/people")!
    
    var people: [Person] = []
    //from the API. these are methods the get/send info
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    //nothing in, nothing out. only need to know when its completed
    func searchForPeopleWith(searchTerm: String, completion: @escaping () -> Void) {
        
        //we are letting swift format the URL for us
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        //query from the API. what we want to pull. A search function. in the API URL the query item is "search"
        let searchTermQueryItem = URLQueryItem(name: "search", value: searchTerm)
        urlComponents?.queryItems = [searchTermQueryItem]
        
        guard let requestURL = urlComponents?.url else {
            print("Error: Request URL is nil!")
            //remeber to always call completion when you have a return
            completion()
            return
        }
        
        var request = URLRequest(url: requestURL)
        //we want the rawValue from the enum
        //modifying the method and setting it to get
        request.httpMethod = HTTPMethod.get.rawValue
        //go down to the completion handeler in the openeing
        //error here initially becuase there is no @escaping in the func inittially
        //creating a shared session. API to App and vice versa.
        //_, we dont care about the return
        //dataTak on a URLSession will run on the background by default everything after "{" is in the background thread
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            guard error == nil else {
                print("Error fetching data: \(error!)")
                completion()
                return
            }
            
            guard let data = data else {
                print("Error: No data return from data task!")
                completion()
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let personSearch = try jsonDecoder.decode(PersonSearch.self, from: data)
                self.people = personSearch.results
            } catch {
                print("Unable to decode data into object of type [Person]: \(error)")
            }
            completion()
            //always call this in the data task for it to run
        }.resume()
    }
}
