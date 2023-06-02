//
//  CardOfDayPresenter.swift
//  AlfaSVK
//
//  Created by Vagan Galstian on 02.06.2023.
//

import Foundation

protocol CardOfDayPresenterProtocol: AnyObject {
    var store: StoreProtocol { get set }
    init(view: CardOfDayVCProtocol, store: StoreProtocol)
    func returnSum(cardOfDay: CardOfDay) -> String
}

final class CardOfDayPresenter: CardOfDayPresenterProtocol {
    
    weak var view: CardOfDayVCProtocol!
    var store: StoreProtocol
    
    required init(view: CardOfDayVCProtocol, store: StoreProtocol) {
        self.view = view
        self.store = store
    }
    
    func returnSum(cardOfDay: CardOfDay) -> String {
        let text = "Заработано: " + cardOfDay.summaryOfDay().intToStringWithSeparator()
        return text
    }
}
