//
//  CountdownController.swift
//  CountdownTracker
//
//  Created by David Wright on 12/19/19.
//  Copyright © 2019 Gerardo Hernandez. All rights reserved.
//

import Foundation

enum SortStyle: Int {
    case time_minToMax
    case time_maxToMin
    case tagName_AToZ
    case tagName_ZToA
    case eventName_AToZ
    case eventName_ZToA
}

class CountdownController {
    
    // MARK: - Initializer

    init() {
        loadFromPersistentStore()
        initializeCountdowns()
        
        let userDefaults = UserDefaults.standard
        
        self.filterIsOn = userDefaults.bool(forKey: .filterIsOnKey)
        self.noTagFilterIsOn = userDefaults.bool(forKey: .noTagFilterIsOnKey)
        
        if let sortStyle = SortStyle(rawValue: userDefaults.integer(forKey: .sortStyleRawValueKey)) {
            self.sortStyle = sortStyle
        }
        
        if let filteredTagNames = userDefaults.array(forKey: .filteredTagNamesKey) as? [String] {
            self.filteredTagNames = filteredTagNames
        }
    }
    
    // MARK: - Properties

    private(set) var countdownData: [CountdownData] = []
    private(set) var countdowns: [Countdown] = []
    
    var filterIsOn: Bool = false { willSet { UserDefaults.standard.set(newValue, forKey: .filterIsOnKey) } }
    var noTagFilterIsOn: Bool = true { willSet { UserDefaults.standard.set(newValue, forKey: .noTagFilterIsOnKey) } }
    
    var sortStyle: SortStyle = .time_minToMax {
        willSet {
            guard newValue != self.sortStyle else { return }
            UserDefaults.standard.set(newValue.rawValue, forKey: .sortStyleRawValueKey)
        }
    }
    
    var filteredTagNames: [String] = [] {
        willSet {
            guard newValue != self.filteredTagNames else { return }
            UserDefaults.standard.set(newValue, forKey: .filteredTagNamesKey)
        }
    }
    
    // MARK: - Computed Properties

    var customTagNames: [String] {
        var result: [String] = []
        for countdown in countdowns {
            let tag = countdown.tag
            if tag != "", !result.contains(tag){
                result.append(tag)
            }
        }
        return result
    }
    
    var customTagFilterSettings: [Bool] { return customTagNames.map { filteredTagNames.contains($0) } }
    var countdownsWithNoTag: [Countdown] { return countdowns.filter { $0.tag == "" } }
    var countdownsWithCustomTag: [Countdown] { return countdowns.filter { $0.tag != "" } }
    var hasCountdownsWithNoTag: Bool { return countdownsWithNoTag.count > 0 }
    var hasCountdownsWithCustomTag: Bool { return countdownsWithCustomTag.count > 0 }

    var displayedCountdowns: [Countdown] {
        var result: [Countdown] = []
        
        if filterIsOn {
            result = countdowns.filter { filteredTagNames.contains($0.tag) }
            if noTagFilterIsOn {
                result += countdownsWithNoTag
            }
        } else {
            result = countdowns
        }
        
        return sortedCountdowns(from: result)
    }

    // MARK: - Sort Methods

    func sortedCountdowns(from countdowns: [Countdown], with sortStyle: SortStyle? = nil) -> [Countdown] {
        let sortStyle = sortStyle ?? self.sortStyle
        
        switch sortStyle {
        case .time_minToMax:
            return countdowns.sorted { $0.eventDate < $1.eventDate }
        case .time_maxToMin:
            return countdowns.sorted { $0.eventDate > $1.eventDate }
        case .tagName_AToZ:
            return countdowns.sorted { $0.tag.lowercased() < $1.tag.lowercased() }
        case .tagName_ZToA:
            return countdowns.sorted { $0.tag.lowercased() > $1.tag.lowercased() }
        case .eventName_AToZ:
            return countdowns.sorted { $0.eventName.lowercased() < $1.eventName.lowercased() }
        case .eventName_ZToA:
            return countdowns.sorted { $0.eventName.lowercased() > $1.eventName.lowercased() }
        }
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
        guard !self.countdownData.contains(countdownData) else { return nil }
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
        countdowns[countdownIndex].eventDate = newCountdownData.eventDate
        countdowns[countdownIndex].eventName = newCountdownData.eventName
        countdowns[countdownIndex].tag = newCountdownData.tag
        countdowns[countdownIndex].start()
        
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

// MARK: - Extensions

extension String {
    static var sortStyleRawValueKey = "SortStyleRawValueKey"
    static var filterIsOnKey = "FilterIsOn"
    static var noTagFilterIsOnKey = "NoTagFilterIsOn"
    static var filteredTagNamesKey = "FilteredTagNames"
}
