//
//  Extensions+Int+Date.swift
//  AlfaSVK
//
//  Created by Vagan Galstian on 02.06.2023.
//

import Foundation

extension Date {
    func dateToString() -> String {
        let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yy"
            return formatter
        }()
        
        let date = dateFormatter.string(from: self)
        return date
    }
    
    func dateToMonth() -> String {
        let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_US")
            formatter.dateFormat = "MMMM yyyy"
            return formatter
        }()
        
        let date = dateFormatter.string(from: self)
        return date
    }
}
