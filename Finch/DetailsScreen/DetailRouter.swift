//
//  DetailRouter.swift
//  Finch
//
//  Created by Captain Kidd on 08.07.2021.
//

import Foundation
import UIKit

protocol DetailScreenRouterProtocol {
    
    var entry: UIViewController? { get }
    static func start(row: Int) -> DetailScreenRouterProtocol
}

class DetailScreenRouter: DetailScreenRouterProtocol {
    
    var entry: UIViewController?
    
    static func start(row: Int) -> DetailScreenRouterProtocol {
        let router = DetailScreenRouter()
        
        //vip
        var view: DetailScreenViewControllerProtocol = DetailScreenViewController()
        var presenter: DetailScreenPresenterProtocol = DetailScreenPresenter()
        var interactor: DetailScreenInteractorProtocol = DetailScreenInteractor()
        
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        router.entry = view as? UIViewController
        presenter.getRowDetails(row: row)
        
        return router
    }
    
}
