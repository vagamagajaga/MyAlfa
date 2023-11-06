//
//  Store.swift
//  AlfaSVK
//
//  Created by Vagan Galstian on 04.05.2023.
//

import Foundation

protocol StoreProtocol {
    var months: [MonthData] { get set }
    func addDay(day: CardOfDay, monthIndex: Int)
    func removeDay(indexPath: IndexPath, monthIndex: Int)
    func addMonth()
}

final class Store: StoreProtocol {
    
    //MARK: - Properties
    private let defaults = UserDefaults.standard
    private let key = "Months"
    
    var months: [MonthData] {
        get {
            guard let data = defaults.data(forKey: key),
                  let storedMonths = try? JSONDecoder().decode([MonthData].self, from: data) else {
                return []
            }
            return storedMonths
        }
        set {
            guard let data = try? JSONEncoder().encode(newValue) else {
                return
            }
            defaults.setValue(data, forKey: key)
        }
    }
    
    //MARK: - Methods
    func addMonth() {
        months.append(MonthData(monthOfYear: Date(), days: []))
    }
    
    func addDay(day: CardOfDay, monthIndex: Int) {
        months[monthIndex].days.append(day)
    }
    
    func removeDay(indexPath: IndexPath, monthIndex: Int) {
        months[monthIndex].days.remove(at: indexPath.row)
    }
}
