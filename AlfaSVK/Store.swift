//
//  Store.swift
//  AlfaSVK
//
//  Created by Vagan Galstian on 04.05.2023.
//

import Foundation

protocol StoreProtocol {
    var meetings: [CardOfDay] { get set }
    func removeDay(indexPath: IndexPath)
    func addDay(day: CardOfDay)
}

final class Store: StoreProtocol {
    
    //MARK: - Properties
    private let defaults = UserDefaults.standard
    private let key = "Meetings"
    
    var meetings: [CardOfDay] {
        get {
            guard let data = defaults.data(forKey: key),
                  let days = try? JSONDecoder().decode([CardOfDay].self, from: data) else {
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
    
    func addDay(day: CardOfDay) {
        meetings.append(day)
    }
}
