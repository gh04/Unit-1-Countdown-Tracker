//
//  CountdownController.swift
//  CountdownTracker
//
//  Created by David Wright on 12/19/19.
//  Copyright © 2019 Gerardo Hernandez. All rights reserved.
//

import Foundation

class CountdownController {
    
    // MARK: - Initializer

    init() {
        
    }
    
    // MARK: - Properties

    private(set) var countdownData: [CountdownData] = []
    
    var countdowns: [Countdown] = []

    // MARK: - CRUD Methods
    
    func createCountdown() {
        
    }

    func deleteCountdown() {
        
    }
    
    func updateCountdown() {
        
    }
    
    // MARK: - Persistence

    private var countdownTrackerURL: URL? {
        let fm = FileManager.default
        guard let dir = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return dir.appendingPathComponent("CountdownTracker.plist")
    }
    
    private func saveToPersistentStore() {
        guard let url = countdownTrackerURL else { return }
        let encoder = PropertyListEncoder()
        
        do {
            let countdownsData = try encoder.encode(countdownData)
            try countdownsData.write(to: url)
        } catch {
            NSLog("Error saving countdowns data: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        do {
            let fm = FileManager.default
            guard let url = countdownTrackerURL, fm.fileExists(atPath: url.path) else { return }
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodeCountdowns = try decoder.decode([CountdownData].self, from: data)
            countdownData = decodeCountdowns
        } catch {
            NSLog("Error loading countdowns data: \(error)")
        }
    }
    
}

