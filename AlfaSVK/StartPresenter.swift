//
//  StartPresenter.swift
//  AlfaSVK
//
//  Created by Vagan Galstian on 03.06.2023.
//

import Foundation

protocol StartPresenterProtocol: AnyObject {
    init(view: StartVCProtocol, router: RouterProtocol)
    func tapOnGo()
}

final class StartPresenter: StartPresenterProtocol {
    
    //MARK: - Properties
    weak var view: StartVCProtocol?
    var router: RouterProtocol?
    
    //MARK: - Lifecycles
    init(view: StartVCProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
    
    //MARK: - Methods
    func tapOnGo() {
        router?.showMeetingDays()
    }
}
