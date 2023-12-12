//
//  MonthsPresenter.swift
//  AlfaSVK
//
//  Created by Vagan Galstian on 31.07.2023.
//

import Foundation

protocol MonthsPresenterProtocol {
    var store: StoreProtocol { get }
    init(view: MonthsVCProtocol, store: StoreProtocol, router: RouterProtocol)
    func createMonth()
    func showChosenMonth(indexPath monthNumber: Int)
    func detailOfMonth(indexPath: IndexPath) -> String
    func summaryOfMonth(indexPath: IndexPath) -> String
}

final class MonthsPresenter: MonthsPresenterProtocol {
    
    //MARK: - Properties
    weak var view: MonthsVCProtocol!
    var store: StoreProtocol
    var router: RouterProtocol
    
    //MARK: - Init
    required init(view: MonthsVCProtocol, store: StoreProtocol, router: RouterProtocol) {
        self.view = view
        self.store = store
        self.router = router
    }
    
    //MARK: - Methods
    func createMonth() {
        if store.months.isEmpty || store.months.last?.monthOfYear.dateToMonth() != Date().dateToMonth() {
            store.addMonth()
        }
        view.updateData()
    }
    
    func showChosenMonth(indexPath monthNumber: Int) {
        router.showMonthMeetings(monthNumber: monthNumber)
    }
    
    func detailOfMonth(indexPath: IndexPath) -> String {
        return store.months[indexPath.row].monthOfYear.dateToMonth()
    }
    
    func summaryOfMonth(indexPath: IndexPath) -> String {
        var sum = 0
        store.months[indexPath.row].days.forEach { sum += $0.summaryOfDay()
        }
        return sum.intToStringWithSeparator()
    }
}
