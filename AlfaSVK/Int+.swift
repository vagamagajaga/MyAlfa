//
//  Extension+Int.swift
//  AlfaSVK
//
//  Created by Vagan Galstian on 05.06.2023.
//

import Foundation

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
