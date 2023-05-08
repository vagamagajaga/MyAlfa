//
//  Store.swift
//  AlfaSVK
//
//  Created by Vagan Galstian on 04.05.2023.
//

import Foundation

final class Store {
    
    //MARK: - Properties
    private let defaults = UserDefaults.standard
    private let key = "Meetings"
    
    var meetings: [Day] {
        get {
            guard let data = defaults.data(forKey: key),
                  let days = try? JSONDecoder().decode([Day].self, from: data) else {
                return []
            }
            return days
        }
        set {
            guard let data = try? JSONEncoder().encode(newValue) else {
                return
            }
            defaults.setValue(data, forKey: key)
        }
    }
    
    //MARK: - Methods
    func removeDay(indexPath: IndexPath) {
        meetings.remove(at: indexPath.row)
    }
    
    func addDay(day: Day) {
        meetings.append(day)
    }
}
