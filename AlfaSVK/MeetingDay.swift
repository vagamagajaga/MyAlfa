//
//  MeetingDay.swift
//  AlfaSVK
//
//  Created by Vagan Galstian on 04.05.2023.
//

import Foundation

struct Day: Codable {
    var sum: Int {
        guard let priceForRKO = bankProductsPrice.RKO(0).intValue, //для чего мы вставляем число в скобку?
              let priceForPIL = bankProductsPrice.PIL(0).intValue,
              let priceForMirPay = bankProductsPrice.mirPay(0).intValue,
              let priceForCarLoan = bankProductsPrice.carLoan(0).intValue,
              let priceForCrossDC = bankProductsPrice.crossDC(0).intValue,
              let priceForCrossCC = bankProductsPrice.crossCC(0).intValue,
              let priceForIssuedDC = bankProductsPrice.issuedDC(0).intValue,
              let priceForIssuedCC = bankProductsPrice.issuedCC(0).intValue,
              let priceForIssuedCC2 = bankProductsPrice.issuedCC2(0).intValue,
              let priceForBrokerageAccount = bankProductsPrice.brokerageAccount(0).intValue else {
            return 0
        }
        
        return (RKO ?? 0) * priceForRKO +
        (PIL ?? 0) * priceForPIL +
        (mirPay ?? 0) * priceForMirPay +
        (carLoan ?? 0) * priceForCarLoan +
        (crossDC ?? 0) * priceForCrossDC +
        (crossCC ?? 0) * priceForCrossCC +
        (issuedDC ?? 0) * priceForIssuedDC +
        (issuedCC ?? 0) * priceForIssuedCC +
        (issuedCC2 ?? 0) * priceForIssuedCC2 +
        (brokerageAccount ?? 0) * priceForBrokerageAccount
    }
    
    var RKO: Int?
    var PIL: Int?
    var date: Date
    var mirPay: Int?
    var carLoan: Int?
    var crossDC: Int?
    var crossCC: Int?
    var issuedDC: Int?
    var issuedCC: Int?
    var issuedCC2: Int?
    var comment: String?
    var brokerageAccount: Int?
    
    enum bankProductsPrice {
        case RKO(Int)
        case PIL(Int)
        case mirPay(Int)
        case carLoan(Int)
        case crossDC(Int)
        case crossCC(Int)
        case issuedDC(Int)
        case issuedCC(Int)
        case issuedCC2(Int)
        case brokerageAccount(Int)
        
        var intValue: Int? {
            switch self {
            case .RKO:
                return 380
            case .PIL:
                return 380
            case .mirPay:
                return 100
            case .carLoan:
                return 380
            case .crossDC:
                return 300
            case .crossCC:
                return 300
            case .issuedDC:
                return 250
            case .issuedCC:
                return 380
            case .issuedCC2:
                return 380
            case .brokerageAccount:
                return 600
            }
        }
    }
}
