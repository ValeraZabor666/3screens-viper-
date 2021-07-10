//
//  AddRouter.swift
//  Finch
//
//  Created by Captain Kidd on 07.07.2021.
//

import Foundation
import UIKit

protocol AddingScreenRouterProtocol {
    
    var entry: UIViewController? { get }
    static func start() -> AddingScreenRouterProtocol
    func backToBase()
}

class AddingScreenRouter: AddingScreenRouterProtocol {
    
    var entry: UIViewController?
    
    static func start() -> AddingScreenRouterProtocol {
        let router = AddingScreenRouter()
        
        //vip
        var view: AddingScreenViewControllerProtocol = AddingScreenViewController()
        var presenter: AddingScreenPresenterProtocol = AddingScreenPresenter()
        var interactor: AddingScreenInteractorProtocol = AddingScreenInteractor()
        
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        router.entry = view as? UIViewController
        
        return router
    }
    
    func backToBase() {
        entry?.navigationController?.popViewController(animated: true)
    }
}
