//
//  MeetingDay.swift
//  AlfaSVK
//
//  Created by Vagan Galstian on 04.05.2023.
//

import Foundation

struct CardOfDay: Codable {
    var date: Date
    var comment: String?
    var arrayOfProducts: [Product] = [
    Product(name: "DC", count: 0, price: 250),
    Product(name: "CC", count: 0, price: 380),
    Product(name: "CC2", count: 0, price: 380),
    Product(name: "CrossDC", count: 0, price: 300),
    Product(name: "CrossCC", count: 0, price: 300),
    Product(name: "ZPC", count: 0, price: 250),
    Product(name: "MirPay", count: 0, price: 100),
    Product(name: "RKO", count: 0, price: 380),
    Product(name: "PIL", count: 0, price: 380),
    Product(name: "CarLoan", count: 0, price: 380),
    Product(name: "BC", count: 0, price: 600),
    Product(name: "Селфи", count: 0, price: 300),
    Product(name: "RE", count: 0, price: 250)
    ]
    
    func summaryOfDay() -> Int {
        var sum = 0
        for i in arrayOfProducts {
            sum += i.count * i.price
        }
        return sum
    }
    
    func sumOfCards() -> Int {
        var countOfCards = 0
        for i in 0...12 {
            if i >= 0 && i <= 5 || i >= 11 && i <= 12 && arrayOfProducts.indices.contains(i) {
                countOfCards += arrayOfProducts[i].count
            }
        }
        
        return countOfCards
    }
}

extension CardOfDay {
    struct Product: Codable {
        var name: String
        var count: Int
        var price: Int
    }
}

