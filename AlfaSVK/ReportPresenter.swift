//
//  ReportPresenter.swift
//  AlfaSVK
//
//  Created by Vagan Galstian on 29.05.2023.
//

import Foundation

protocol ReportPresenterProtocol: AnyObject {
    var store: StoreProtocol { get set }
    init(view: ReportVCProtocol, store: StoreProtocol)
    func returnReportText(cardOfDay: CardOfDay) -> String
    func checkForIndex(product: [CardOfDay.Product], index: Int) -> Int
}

final class ReportPresenter: ReportPresenterProtocol {
    
    weak var view: ReportVCProtocol!
    var store: StoreProtocol
    
    required init(view: ReportVCProtocol, store: StoreProtocol) {
        self.view = view
        self.store = store
    }
    
    //kosyak тут правильно
    func checkForIndex(product: [CardOfDay.Product], index: Int) -> Int {
        if product.indices.contains(index) {
            return product[index].count
        }
        return 0
    }
    //kosyak тут правильно
    func returnReportText(cardOfDay: CardOfDay) -> String {
        let products = cardOfDay.arrayOfProducts
        let date = cardOfDay.date.dateToString()
        
        let text = """
            Отчет за \(date)
            Район: \(cardOfDay.comment ?? "Не указан")
            
            DC \(products[0].count)/0
            
            СС \(products[1].count)/0
            
            СС2 \(products[2].count)/0
            
            ZPC \(products[5].count)/0
            
            RE \(checkForIndex(product: products, index: 12))/0
            
            RKO \(products[7].count)/0
            
            PIL \(products[8].count)/0
            
            Автокредит \(products[9].count)/0
            
            КРОССЫ
            
            ДК \(products[3].count)
            КК \(products[0].count + products[5].count)/0/\(products[4].count)
            
            НС
            БС \(products[10].count)
            
            MirPay \(cardOfDay.sumOfCards())/андроиды/\(products[6].count)
            Селфи \(checkForIndex(product: products, index: 11))
            """
        
        return text
        
    }
    
    
}

    //что стоит предать в задачи презентеру?
