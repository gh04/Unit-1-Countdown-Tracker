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
        loadFromPersistentStore()
        
        for data in countdownData {
            let countdown = Countdown(with: data)
            countdowns.append(countdown)
        }
    }
    
    // MARK: - Properties

    private(set) var countdownData: [CountdownData] = []
    
    private(set) var countdowns: [Countdown] = []
    
    var tags: [String] {
        var result: [String] = []
        
        for countdown in countdownData {
            if let tag = countdown.tag,
            !result.contains(tag){
                result.append(tag)
            }
        }
        return result
    }

    // MARK: - CRUD Methods
    
    @discardableResult func createCountdown(with countdownData: CountdownData) -> Countdown? {
        guard !self.countdownData.contains(countdownData) else { return nil }
        
        self.countdownData.append(countdownData)
        countdowns.append(Countdown(with: countdownData))
        saveToPersistentStore()
        
        return Countdown(with: countdownData)
    }

    func deleteCountdown(with countdownData: CountdownData) {
        guard let countdownDataIndex = self.countdownData.firstIndex(of: countdownData),
            let countdownIndex = self.countdowns.firstIndex(of: Countdown(with: countdownData)) else { return }
        
        self.countdownData.remove(at: countdownDataIndex)
        countdowns.remove(at: countdownIndex)
        saveToPersistentStore()
    }
    
    func updateCountdown(from currentCountdownData: CountdownData, to newCountdownData: CountdownData) {
        guard let countdownDataIndex = self.countdownData.firstIndex(of: currentCountdownData),
            let countdownIndex = self.countdowns.firstIndex(of: Countdown(with: currentCountdownData)) else { return }
        
        self.countdownData.remove(at: countdownDataIndex)
        self.countdownData.append(newCountdownData)
        countdowns.remove(at: countdownIndex)
        countdowns.append(Countdown(with: newCountdownData))
        saveToPersistentStore()
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

