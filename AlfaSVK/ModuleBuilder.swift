//
//  ModuleBuilder.swift
//  AlfaSVK
//
//  Created by Vagan Galstian on 29.05.2023.
//

import UIKit

protocol Builder {
    static func createStartVC() -> UIViewController
    static func createMeetingVC() -> UIViewController
    static func createCardOfDayVC(cardOfDay: CardOfDay, numberOfDay: Int, doWeChooseCard: Bool) -> UIViewController
    static func createReportVC(carDofDay: CardOfDay) -> UIViewController
}
//kosyak - final class
class ModuleBuilder: Builder {
    static func createStartVC() -> UIViewController {
        let view = StartVC()
        return view
    }
    
    static func createMeetingVC() -> UIViewController {
        let store = Store()
        let view = MeetingVC()
        let presenter = MeetingPresenter(view: view, store: store)
        view.presenter = presenter
        return view
    }
    
    static func createCardOfDayVC(cardOfDay: CardOfDay, numberOfDay: Int, doWeChooseCard: Bool) -> UIViewController {
        let store = Store()
        let view = CardOfDayVC(numberOfDay: numberOfDay, doWeChooseCard: doWeChooseCard)
        view.cardOfDay = cardOfDay
        let presenter = CardOfDayPresenter(view: view, store: store)
        view.presenter = presenter
        return view
    }
    
    static func createReportVC(carDofDay: CardOfDay) -> UIViewController {
        let store = Store()
        let view = ReportVC()
        view.cardOfDay = carDofDay
        let presenter = ReportPresenter(view: view, store: store)
        view.presenter = presenter
        return view
    }
}
