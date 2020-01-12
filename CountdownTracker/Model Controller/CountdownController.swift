//
//  CountdownController.swift
//  CountdownTracker
//
//  Created by David Wright on 12/19/19.
//  Copyright © 2019 Gerardo Hernandez. All rights reserved.
//

import Foundation

enum SortStyle {
    case time_minToMax
    case time_maxToMin
    case tagName_AToZ
    case tagName_ZToA
}

class CountdownController {
    
    // MARK: - Initializer

    init() {
        loadFromPersistentStore()
        initializeCountdowns()
    }
    
    // MARK: - Properties

    private(set) var countdownData: [CountdownData] = []
    
    private(set) var countdowns: [Countdown] = []
    
    var filterIsOn: Bool = true //MARK: TODO: Add filterIsOn to UserDefaults
    
    var noTagFilterIsOn: Bool = true
    
    var sortStyle: SortStyle = .time_minToMax {
        didSet {
            sortDisplayedCountdowns()
        }
    }
    
    lazy var filteredTagNames: [String] = tagNames
    
    // MARK: - Computed Properties

    var tagNames: [String] {
        var result: [String] = []
        for countdown in countdowns {
            let tag = countdown.tag
            if tag != "", !result.contains(tag){
                result.append(tag)
            }
        }
        return result
    }
    
    var displayedCountdowns: [Countdown] {
        if filterIsOn {
            if noTagFilterIsOn {
                return countdowns.filter { $0.tag == "" || filteredTagNames.contains($0.tag) }
            } else {
                return countdowns.filter { filteredTagNames.contains($0.tag) }
            }
        } else {
            return countdowns
        }
    }

    var countdownsWithNoTag: [Countdown] {
        return countdowns.filter { $0.tag == "" }
    }
    
    var countdownsWithCustomTag: [Countdown] {
        return countdowns.filter { $0.tag != "" }
    }

    func sortDisplayedCountdowns() {
        //MARK: TODO: Implement Sorting Function
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

