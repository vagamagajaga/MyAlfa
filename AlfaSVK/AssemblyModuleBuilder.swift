//
//  ModuleBuilder.swift
//  AlfaSVK
//
//  Created by Vagan Galstian on 29.05.2023.
//

import UIKit

protocol AssemblyModuleProtocol {
    func createStartVC(router: RouterProtocol) -> UIViewController
    func createMeetingVC(router: RouterProtocol) -> UIViewController
    func createCardOfDayVC(chosenDay: CardOfDay, numberOfDay: Int, doWeChooseCard: Bool, router: RouterProtocol) -> UIViewController
    func createReportVC(cardOfDay: CardOfDay, router: RouterProtocol) -> UIViewController
}

final class AssemblyModuleBuilder: AssemblyModuleProtocol {
    func createStartVC(router: RouterProtocol) -> UIViewController {
        let view = StartVC()
        let presenter = StartPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
    
    func createMeetingVC(router: RouterProtocol) -> UIViewController {
        let store = Store()
        let view = MeetingVC()
        let presenter = MeetingPresenter(view: view, store: store, router: router)
        view.presenter = presenter
        return view
    }
    
    func createCardOfDayVC(chosenDay: CardOfDay, numberOfDay: Int, doWeChooseCard: Bool, router: RouterProtocol) -> UIViewController {
        let store = Store()
        let view = CardOfDayVC()
        let presenter = CardOfDayPresenter(view: view, store: store,
                                           chosenDay: chosenDay,
                                           doWeChooseCard: doWeChooseCard,
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
