//
//  WorkDayPresenter.swift
//  AlfaSVK
//
//  Created by Vagan Galstian on 02.06.2023.
//

import Foundation

protocol WorkDayPresenterProtocol: AnyObject {
    var store: StoreProtocol { get set }
    var chosenDay: BusinessDay { get set }
    var doWeChooseCard: Bool { get set }
    var numberOfDay: Int { get set }
    init(view: WorkDayVCProtocol, store: StoreProtocol, chosenDay: BusinessDay, doWeChooseCard: Bool, numberOfDay: Int, router: RouterProtocol)
    func returnSum(cardOfDay: BusinessDay) -> String
    func showReport()
}

final class WorkDayPresenter: WorkDayPresenterProtocol {
    
    //MARK: - Properties
    weak var view: WorkDayVCProtocol!
    var store: StoreProtocol
    var chosenDay: BusinessDay
    var router: RouterProtocol
    var doWeChooseCard: Bool = false
    var numberOfDay: Int = 0
    
    //MARK: - Init
    required init(view: WorkDayVCProtocol, store: StoreProtocol, chosenDay: BusinessDay, doWeChooseCard: Bool, numberOfDay: Int, router: RouterProtocol) {
        self.view = view
        self.store = store
        self.chosenDay = chosenDay
        self.doWeChooseCard = doWeChooseCard
        self.numberOfDay = numberOfDay
        self.router = router
    }
    
    //MARK: - Methods
    func returnSum(cardOfDay: BusinessDay) -> String {
        let text = "Заработано: " + cardOfDay.summaryOfDay().intToStringWithSeparator()
        return text
    }
    
    func showReport() {
        router.showReportOfDay(cardOfDay: chosenDay)
    }
}
