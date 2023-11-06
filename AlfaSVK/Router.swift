//
//  Router.swift
//  AlfaSVK
//
//  Created by Vagan Galstian on 02.06.2023.
//

import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyModuleProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func initialStartVC()
    func showMonths()
    func showMonthMeetings(monthNumber: Int)
    func showChosenOrNewDay(cardOfDay: CardOfDay, monthNumber: Int, numberOfDay: Int, doWeChooseCard: Bool)
    func showReportOfDay(cardOfDay: CardOfDay)
}

class Router: RouterProtocol {
    
    //MARK: - Properties
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyModuleProtocol?
    
    //MARK: - Init
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyModuleProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    //MARK: - Methods
    func initialStartVC() {
        if let navigationController = navigationController {
            guard let startVC = assemblyBuilder?.createStartVC(router: self) else { return }
            navigationController.viewControllers = [startVC]
        }
    }
    
    func showMonths() {
        if let navigationController = navigationController {
            guard let meetingVC = assemblyBuilder?.createMonthsVC(router: self) else { return }
            navigationController.pushViewController(meetingVC, animated: true)
        }
    }
    
    func showMonthMeetings(monthNumber: Int) {
        if let navigationController = navigationController {
            guard let meetingVC = assemblyBuilder?.createMonthMeetingVC(router: self, monthNumber: monthNumber) else { return }
            navigationController.pushViewController(meetingVC, animated: true)
        }
    }
    
    func showChosenOrNewDay(cardOfDay: CardOfDay, monthNumber: Int, numberOfDay: Int, doWeChooseCard: Bool) {
        if let navigationController = navigationController {
            guard let cardOfDayVC = assemblyBuilder?.createCardOfDayVC(chosenDay: cardOfDay,
                                                                       monthNumber: monthNumber,
                                                                       numberOfDay: numberOfDay,
                                                                       doWeChooseCard: doWeChooseCard,
                                                                       router: self) else { return }
            navigationController.pushViewController(cardOfDayVC, animated: true)
        }
    }
    
    func showReportOfDay(cardOfDay: CardOfDay) {
        if let navigationController = navigationController {
            guard let reportVC = assemblyBuilder?.createReportVC(cardOfDay: cardOfDay, router: self) else { return }
            navigationController.pushViewController(reportVC, animated: true)
        }
    }
}
