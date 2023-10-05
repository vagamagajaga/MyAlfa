//
//  WorkDaysOfMonthPresenter.swift
//  AlfaSVK
//
//  Created by Vagan Galstian on 02.06.2023.
//

import Foundation

protocol WorkDaysOfMonthPresenterProtocol: AnyObject {
    var store: StoreProtocol { get }
    init(view: WorkDaysOfMonthVCProtocol, store: StoreProtocol, router: RouterProtocol)
    func updateBooksByDate()
    func removeDayFromStore(indexPath: IndexPath)
    func addNewDay(numberOfDay: Int, doWeChooseCard: Bool)
    func chooseDayFromList(cardOfDay: BusinessDay, numberOfDay: Int, doWeChooseCard: Bool)
    func summaryOfDayInString(indexPath: IndexPath) -> String
    func detailOfDay(indexPath: IndexPath) -> String
}

final class WorkDaysOfMonthPresenter: WorkDaysOfMonthPresenterProtocol {
    
    //MARK: - Properties
    weak var view: WorkDaysOfMonthVCProtocol!
    var store: StoreProtocol
    var router: RouterProtocol
    
    //MARK: - Init
    required init(view: WorkDaysOfMonthVCProtocol, store: StoreProtocol, router: RouterProtocol) {
        self.view = view
        self.store = store
        self.router = router
    }
    
    //MARK: - Methods
    func updateBooksByDate() {
        if store.monthsWithMeetings.count > 1 {
            store.monthsWithMeetings.sort { $0.date < $1.date }
        }
        view.updateData()
    }
    
    func removeDayFromStore(indexPath: IndexPath) {
        store.removeDay(indexPath: indexPath)
    }
    
    func addNewDay(numberOfDay: Int, doWeChooseCard: Bool) {
        router.showWorkDay(cardOfDay: BusinessMonth.BusinessDay(date: Date()), numberOfDay: numberOfDay, doWeChooseCard: doWeChooseCard)
    }
    
    func chooseDayFromList(cardOfDay: BusinessMonth.BusinessDay, numberOfDay: Int, doWeChooseCard: Bool) {
        router.showWorkDay(cardOfDay: cardOfDay, numberOfDay: numberOfDay, doWeChooseCard: doWeChooseCard)
    }
    
    func summaryOfDayInString(indexPath: IndexPath) -> String {
        store.monthsWithMeetings[indexPath.row].workMonth[indexPath.row].summaryOfDay().intToStringWithSeparator()
    }
    
    func detailOfDay(indexPath: IndexPath) -> String {
        store.monthsWithMeetings[indexPath.row].workMonth[indexPath.row].date.dateToString() + " " + (store.monthsWithMeetings[indexPath.row].workMonth[indexPath.row].comment ?? "")
    }
    
    func saveN
}
