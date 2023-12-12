//
//  CardOfDayPresenter.swift
//  AlfaSVK
//
//  Created by Vagan Galstian on 02.06.2023.
//

import Foundation
import MyPackage

protocol CardOfDayPresenterProtocol: AnyObject {
    var store: StoreProtocol { get set }
    var chosenDay: CardOfDay { get set }
    var doWeChooseCard: Bool { get }
    var numberOfDay: Int { get }
    var monthNumber: Int { get }
    init(view: CardOfDayVCProtocol, store: StoreProtocol, chosenDay: CardOfDay, doWeChooseCard: Bool, monthNumber: Int, numberOfDay: Int, router: RouterProtocol)
    func returnSum(cardOfDay: CardOfDay) -> String
    func showReport()
}

final class CardOfDayPresenter: CardOfDayPresenterProtocol {
    
    //MARK: - Properties
    weak var view: CardOfDayVCProtocol!
    var store: StoreProtocol
    var chosenDay: CardOfDay
    var router: RouterProtocol
    var doWeChooseCard: Bool = false
    var numberOfDay: Int = 0
    var monthNumber: Int
    
    //MARK: - Init
    required init(view: CardOfDayVCProtocol, store: StoreProtocol, chosenDay: CardOfDay, doWeChooseCard: Bool, monthNumber:Int, numberOfDay: Int, router: RouterProtocol) {
        self.view = view
        self.store = store
        self.chosenDay = chosenDay
        self.doWeChooseCard = doWeChooseCard
        self.monthNumber = monthNumber
        self.numberOfDay = numberOfDay
        self.router = router
    }
    
    //MARK: - Methods
    func returnSum(cardOfDay: CardOfDay) -> String {
        let text = "Заработано: " + cardOfDay.summaryOfDay().intToStringWithSeparator()
        return text
    }
    
    func showReport() {
        router.showReportOfDay(cardOfDay: chosenDay)
    }
}
