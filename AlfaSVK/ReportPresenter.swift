//
//  ReportPresenter.swift
//  AlfaSVK
//
//  Created by Vagan Galstian on 29.05.2023.
//

import Foundation

protocol ReportPresenterProtocol: AnyObject {
    var store: StoreProtocol { get set }
    var cardOfDay: CardOfDay { get set }
    init(view: ReportVCProtocol, store: StoreProtocol, cardOfDay: CardOfDay, router: RouterProtocol)
    func returnReportText(cardOfDay: CardOfDay) -> String
    func checkForIndex(product: [CardOfDay.Product], index: Int) -> Int
}

final class ReportPresenter: ReportPresenterProtocol {
    
    //MARK: - Properties
    weak var view: ReportVCProtocol!
    var store: StoreProtocol
    var cardOfDay: CardOfDay
    var router: RouterProtocol
    
    //MARK: - Init
    required init(view: ReportVCProtocol, store: StoreProtocol, cardOfDay: CardOfDay, router: RouterProtocol) {
        self.view = view
        self.store = store
        self.cardOfDay = cardOfDay
        self.router = router
    }
    
    //MARK: - Methods
    func checkForIndex(product: [CardOfDay.Product], index: Int) -> Int {
        if product.indices.contains(index) {
            return product[index].count
        }
        return 0
    }

    func returnReportText(cardOfDay: CardOfDay) -> String {
        let products = cardOfDay.arrayOfProducts
        let date = cardOfDay.date.dateToString()
        
        let text = """
            Отчет за \(date)
            Район: \(cardOfDay.comment ?? "Не указан")
            
            DC \(products[0].count)/\(products[0].count)
            
            Акт: 0/\(products[0].count)
            
            СС \(products[1].count)/\(products[1].count)
            
            Страховка: \(products[1].count)/\(products[1].count)/\(products[1].count)/\(products[1].count)
            
            СС2 \(products[2].count)/\(products[2].count)
            
            Транз: 0/\(products[1].count + products[2].count)
            
            ZPC \(products[5].count)/\(products[5].count)
            
            RE \(checkForIndex(product: products, index: 12))/\(checkForIndex(product: products, index: 12))
            
            RKO \(products[7].count)/\(products[7].count)
            
            PIL \(products[8].count)/\(products[8].count)
            
            Автокредит \(products[9].count)/\(products[9].count)
            
            T0 
            
            КРОССЫ
            
            ДК \(products[3].count)
            КК \(products[0].count + products[5].count)/0/\(products[4].count)
            
            НС
            БС \(products[10].count)
            
            MirPay \(products[6].count)
            Селфи \(checkForIndex(product: products, index: 11))
            """
        
        return text
    }
}
