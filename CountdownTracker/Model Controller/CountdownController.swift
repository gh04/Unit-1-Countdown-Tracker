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
        initializeCountdowns()
    }
    
    // MARK: - Properties

    private(set) var countdownData: [CountdownData] = []
    
    private(set) var countdowns: [Countdown] = []
    
    var tags: [String] {
        var result: [String] = []
        
        for countdown in countdowns {
            if let tag = countdown.tag,
            !result.contains(tag){
                result.append(tag)
            }
        }
        return result
    }

    // MARK: - CRUD Methods
    
    func initializeCountdowns() {
        for data in countdownData {
            let newCountdown = Countdown(with: data)
            newCountdown.start()
            countdowns.append(newCountdown)
        }
    }
    
    @discardableResult func createCountdown(with countdownData: CountdownData) -> Countdown? {
        //guard !self.countdownData.contains(countdownData) else { return nil }
        
        self.countdownData.append(countdownData)
        
        let newCountdown = Countdown(with: countdownData)
        newCountdown.start()
        countdowns.append(newCountdown)
        saveToPersistentStore()
        
        return Countdown(with: countdownData)
    }

    func deleteCountdown(with countdownData: CountdownData) {
        guard let countdownDataIndex = self.countdownData.firstIndex(of: countdownData) else { return }
        guard let countdownIndex = self.countdowns.firstIndex(of: Countdown(with: countdownData)) else { return }
        
        self.countdownData.remove(at: countdownDataIndex)
        countdowns[countdownIndex].cancelTimer()
        countdowns.remove(at: countdownIndex)
        saveToPersistentStore()
    }
    
    func updateCountdown(from currentCountdownData: CountdownData, to newCountdownData: CountdownData) {
        guard let countdownDataIndex = self.countdownData.firstIndex(of: currentCountdownData) else { return }
        guard let countdownIndex = self.countdowns.firstIndex(of: Countdown(with: currentCountdownData)) else { return }
        
        countdownData[countdownDataIndex].eventDate = newCountdownData.eventDate
        countdownData[countdownDataIndex].eventName = newCountdownData.eventName
        countdownData[countdownDataIndex].tag = newCountdownData.tag
//        countdownData.insert(newCountdownData, at: countdownDataIndex)
//        countdownData.remove(at: countdownDataIndex + 1)

        countdowns[countdownIndex].eventDate = newCountdownData.eventDate
        countdowns[countdownIndex].eventName = newCountdownData.eventName
        countdowns[countdownIndex].tag = newCountdownData.tag
        countdowns[countdownIndex].start()
//        let newCountdown = Countdown(with: newCountdownData)
//        countdowns.insert(newCountdown, at: countdownIndex)
//        countdowns.remove(at: countdownIndex + 1)
        
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
            let data = try encoder.encode(countdownData)
            try data.write(to: url)
        } catch {
            NSLog("Error saving countdownData: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        do {
            let fm = FileManager.default
            guard let url = countdownTrackerURL, fm.fileExists(atPath: url.path) else { return }
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodeCountdownData = try decoder.decode([CountdownData].self, from: data)
            countdownData = decodeCountdownData
        } catch {
            NSLog("Error loading countdownData: \(error)")
        }
    }
    
}

