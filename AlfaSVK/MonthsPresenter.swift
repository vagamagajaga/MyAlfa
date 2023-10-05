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
    func updateMonthsByDate()
    func removeMonthFromStore(indexPath: IndexPath)
    func addNewMonth(numberOfMonth: Int, doWeChooseMonth: Bool)
    func chooseMonthFromList(month: CardOfDay)
}

class MonthsPresenter: MonthsPresenterProtocol {
    
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
    func updateMonthsByDate() {
        if store.meetings.count > 1 {
            store.meetings.sort { $0.date < $1.date }
        }
        view.updateData()
    }
    
    func addNewMonth(numberOfMonth: Int, doWeChooseMonth: Bool) {
        
    }
    
    func removeMonthFromStore(indexPath: IndexPath) {
        
    }
    
    func chooseMonthFromList(month: CardOfDay) {
        
    }
    
}
