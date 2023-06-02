//
//  MeetingPresenter.swift
//  AlfaSVK
//
//  Created by Vagan Galstian on 02.06.2023.
//

import Foundation

protocol MeetingPresenterProtocol: AnyObject {
    var store: StoreProtocol { get set } //kosyak удали set и проверь изменится ли что то? Если нет, наверное он не нужен. Инкапсуляция типо
    init(view: MeetingVCProtocol, store: StoreProtocol)
    func updateBooksByDate()
}

final class MeetingPresenter: MeetingPresenterProtocol {
    
    weak var view: MeetingVCProtocol!
    var store: StoreProtocol
    
    required init(view: MeetingVCProtocol, store: StoreProtocol) {
        self.view = view
        self.store = store
    }
    
    func updateBooksByDate() {
        if store.meetings.count > 1 {
            store.meetings.sort { $0.date < $1.date }
        }
        //kosyak
        //Презентер не должен обращаться к каким то вещам в вьюхе, презентер должен сказать вызмать метод контроллера -> view.updateData() -> и там вызываться reloadData()
        view.tableView.reloadData()
    }
}
