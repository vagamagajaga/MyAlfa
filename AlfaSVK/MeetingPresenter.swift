//
//  MeetingPresenter.swift
//  AlfaSVK
//
//  Created by Vagan Galstian on 02.06.2023.
//

import Foundation

protocol MeetingPresenterProtocol: AnyObject {
    var monthNumber: Int { get }
    var store: StoreProtocol { get }
    init(view: MeetingVCProtocol, store: StoreProtocol, router: RouterProtocol, monthNumber: Int)
    func updateDaysByDate()
    func removeDayFromStore(indexPath: IndexPath)
    func addNewDay( monthNumber: Int, numberOfDay: Int, doWeChooseCard: Bool)
    func chooseDayFromList(cardOfDay: CardOfDay,  monthNumber: Int, numberOfDay: Int, doWeChooseCard: Bool)
    func summaryOfDayInString(indexPath: IndexPath) -> String
    func detailOfDay(indexPath: IndexPath) -> String
}

final class MeetingPresenter: MeetingPresenterProtocol {
    
    //MARK: - Properties
    weak var view: MeetingVCProtocol!
    var store: StoreProtocol
    var router: RouterProtocol
    var monthNumber: Int
    
    //MARK: - Init
    required init(view: MeetingVCProtocol, store: StoreProtocol, router: RouterProtocol, monthNumber: Int) {
        self.view = view
        self.store = store
        self.router = router
        self.monthNumber = monthNumber
    }
    
    //MARK: - Methods
    func updateDaysByDate() {
        if store.months[monthNumber].days.count > 1 {
            store.months[monthNumber].days.sort { $0.date < $1.date }
        }
        view.updateData()
    }
    
    func removeDayFromStore(indexPath: IndexPath) {
        store.removeDay(indexPath: indexPath, monthIndex: monthNumber)
    }
    
    func addNewDay(monthNumber: Int, numberOfDay: Int, doWeChooseCard: Bool) {
        router.showChosenOrNewDay(cardOfDay: CardOfDay(date: Date()), monthNumber: monthNumber, numberOfDay: numberOfDay, doWeChooseCard: doWeChooseCard)
    }
    
    func chooseDayFromList(cardOfDay: CardOfDay, monthNumber: Int, numberOfDay: Int, doWeChooseCard: Bool) {
        router.showChosenOrNewDay(cardOfDay: cardOfDay, monthNumber: monthNumber, numberOfDay: numberOfDay, doWeChooseCard: doWeChooseCard)
    }
    
    func summaryOfDayInString(indexPath: IndexPath) -> String {
        store.months[monthNumber].days[indexPath.row].summaryOfDay().intToStringWithSeparator()
    }
    
    func detailOfDay(indexPath: IndexPath) -> String {
        store.months[monthNumber].days[indexPath.row].date.dateToString() + " " + (store.months[monthNumber].days[indexPath.row].comment ?? "")
    }
}
