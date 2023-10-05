//
//  BusinessMonth.swift
//  AlfaSVK
//
//  Created by Vagan Galstian on 04.05.2023.
//

import Foundation

struct BusinessMonth: Codable {
    var date: Date
    var workMonth: [BusinessDay]
    
    func summaryOfMonth() -> Int {
        var sum = 0
        for i in workMonth {
            sum += i.summaryOfDay()
        }
        return sum
    }
    
    func countOfProducts() -> Int {
        var count = 0
        for i in workMonth {
            for y in i.arrayOfProducts {
                count += y.count
            }
        }
        return count
    }
    
    func countOfDK() -> Int {
        var count = 0
        for i in workMonth {
            count += i.arrayOfProducts[0].count
        }
        return count
    }
    
    func countOfCC() -> Int {
        var count = 0
        for i in workMonth {
            count += i.arrayOfProducts[1].count
        }
        return count
    }
    
    func countOfCC2() -> Int {
        var count = 0
        for i in workMonth {
            count += i.arrayOfProducts[2].count
        }
        return count
    }
}

extension BusinessMonth {
    struct BusinessDay: Codable {
        
        //MARK: - Properties
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
            Product(name: "CL", count: 0, price: 380),
            Product(name: "BC", count: 0, price: 600),
            Product(name: "Селфи", count: 0, price: 300),
            Product(name: "RE", count: 0, price: 250),
            Product(name: "ЦП", count: 0, price: 100),
            Product(name: "Ипотека", count: 0, price: 380)
        ]
        
        //MARK: - Methods
        func summaryOfDay() -> Int {
            var sum = 0
            for i in arrayOfProducts {
                sum += i.count * i.price
            }
            return sum
        }
    }
}

extension BusinessMonth {
    struct Product: Codable {
        var name: String
        var count: Int
        var price: Int
    }
}
