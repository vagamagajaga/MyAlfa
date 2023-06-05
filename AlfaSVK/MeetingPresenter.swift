//
//  MeetingPresenter.swift
//  AlfaSVK
//
//  Created by Vagan Galstian on 02.06.2023.
//

import Foundation

protocol MeetingPresenterProtocol: AnyObject {
    var store: StoreProtocol { get }
    init(view: MeetingVCProtocol, store: StoreProtocol, router: RouterProtocol)
    func updateBooksByDate()
    func removeDayFromStore(indexPath: IndexPath)
    func addNewDay(numberOfDay: Int, doWeChooseCard: Bool)
    func chooseDayFromList(cardOfDay: CardOfDay, numberOfDay: Int, doWeChooseCard: Bool)
    func summaryOfDayInString(indexPath: IndexPath) -> String
    func detailOfDay(indexPath: IndexPath) -> String
}

final class MeetingPresenter: MeetingPresenterProtocol {
    
    //MARK: - Properties
    weak var view: MeetingVCProtocol!
    var store: StoreProtocol
    var router: RouterProtocol
    
    //MARK: - Init
    required init(view: MeetingVCProtocol, store: StoreProtocol, router: RouterProtocol) {
        self.view = view
        self.store = store
        self.router = router
    }
    
    //MARK: - Methods
    func updateBooksByDate() {
        if store.meetings.count > 1 {
            store.meetings.sort { $0.date < $1.date }
        }
        view.updateData()
    }
    
    func removeDayFromStore(indexPath: IndexPath) {
        store.removeDay(indexPath: indexPath)
    }
    
    func addNewDay(numberOfDay: Int, doWeChooseCard: Bool) {
        router.showChosenOrNewDay(cardOfDay: CardOfDay(date: Date()), numberOfDay: numberOfDay, doWeChooseCard: doWeChooseCard)
    }
    
    func chooseDayFromList(cardOfDay: CardOfDay, numberOfDay: Int, doWeChooseCard: Bool) {
        router.showChosenOrNewDay(cardOfDay: cardOfDay, numberOfDay: numberOfDay, doWeChooseCard: doWeChooseCard)
    }
    
    func summaryOfDayInString(indexPath: IndexPath) -> String {
        store.meetings[indexPath.row].summaryOfDay().intToStringWithSeparator()
    }
    
    func detailOfDay(indexPath: IndexPath) -> String {
        store.meetings[indexPath.row].date.dateToString() + " " + (store.meetings[indexPath.row].comment ?? "")
    }
}
