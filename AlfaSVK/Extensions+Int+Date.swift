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
}

extension Int {
    func intToStringWithSeparator() -> String {
        let numberFormatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.groupingSeparator = " "
            return formatter
        }()
        let num = numberFormatter.string(from: self as NSNumber) ?? "0"
        return num
    }
}
