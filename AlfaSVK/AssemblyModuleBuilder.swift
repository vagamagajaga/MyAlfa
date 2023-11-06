//
//  ModuleBuilder.swift
//  AlfaSVK
//
//  Created by Vagan Galstian on 29.05.2023.
//

import UIKit

protocol AssemblyModuleProtocol {
    func createStartVC(router: RouterProtocol) -> UIViewController
    func createMonthsVC(router: RouterProtocol) -> UIViewController
    func createMonthMeetingVC(router: RouterProtocol, monthNumber: Int) -> UIViewController
    func createCardOfDayVC(chosenDay: CardOfDay, monthNumber: Int, numberOfDay: Int, doWeChooseCard: Bool, router: RouterProtocol) -> UIViewController
    func createReportVC(cardOfDay: CardOfDay, router: RouterProtocol) -> UIViewController
}

final class AssemblyModuleBuilder: AssemblyModuleProtocol {
    func createStartVC(router: RouterProtocol) -> UIViewController {
        let view = StartVC()
        let presenter = StartPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
    
    func createMonthsVC(router: RouterProtocol) -> UIViewController {
        let store = Store()
        let view = MonthsVC()
        let presenter = MonthsPresenter(view: view, store: store, router: router)
        view.presenter = presenter
        return view
    }
    
    func createMonthMeetingVC(router: RouterProtocol, monthNumber: Int) -> UIViewController {
        let store = Store()
        let view = MeetingVC()
        let presenter = MeetingPresenter(view: view, store: store, router: router, monthNumber: monthNumber)
        view.presenter = presenter
        return view
    }
    
    func createCardOfDayVC(chosenDay: CardOfDay, monthNumber: Int, numberOfDay: Int, doWeChooseCard: Bool, router: RouterProtocol) -> UIViewController {
        let store = Store()
        let view = CardOfDayVC()
        let presenter = CardOfDayPresenter(view: view,
                                           store: store,
                                           chosenDay: chosenDay,
                                           doWeChooseCard: doWeChooseCard,
                                           monthNumber: monthNumber,
                                           numberOfDay: numberOfDay,
                                           router: router)
        view.presenter = presenter
        return view
    }
    
    func createReportVC(cardOfDay: CardOfDay, router: RouterProtocol) -> UIViewController {
        let store = Store()
        let view = ReportVC()
        let presenter = ReportPresenter(view: view, store: store, cardOfDay: cardOfDay, router: router)
        view.presenter = presenter
        return view
    }
}
