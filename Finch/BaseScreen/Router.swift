//
//  Router.swift
//  Finch
//
//  Created by Captain Kidd on 06.07.2021.
//

import Foundation
import UIKit

typealias EntryPoint = BaseScreenViewControllerProtocol & UIViewController

protocol BaseScreenRouterProtocol {
    var entry: EntryPoint? { get }
    
    static func start() -> BaseScreenRouterProtocol

    func addNewElement()
    func elementDetails(row: Int)
}

class BaseScreenRouter: BaseScreenRouterProtocol {
    
    var entry: EntryPoint?
    
    static func start() -> BaseScreenRouterProtocol {
        let router = BaseScreenRouter()
        
        var view: BaseScreenViewControllerProtocol = BaseScreenViewController()
        var presenter: BaseScreenPresenterProtocol = BaseScreenPresenter()
        var interactor: BaseScreenInteractorProtocol = BaseScreenInteractor()
        
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        router.entry = view as? EntryPoint
        
        
        return router
    }
    
    func addNewElement() {
        let vc = AddingScreenRouter.start()
        let destVc = vc.entry
        entry?.navigationController?.pushViewController(destVc!, animated: true)
    }
    
    func elementDetails(row: Int) {
        let vc = DetailScreenRouter.start(row: row)
        let destVc = vc.entry
        entry?.navigationController?.pushViewController(destVc!, animated: true)
    }
}
