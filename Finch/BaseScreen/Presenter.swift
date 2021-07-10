//
//  Presenter.swift
//  Finch
//
//  Created by Captain Kidd on 06.07.2021.
//

import Foundation
//object
//protocol
// ref to interactor, router, view

protocol BaseScreenPresenterProtocol {
    var router: BaseScreenRouterProtocol? { get set }
    var interactor: BaseScreenInteractorProtocol? { get set }
    var view: BaseScreenViewControllerProtocol? { get set }
    func addNewElementButton()
    func elementDetailsClicked(row: Int)
    func deletePickedElement(indexPath: Int)
    func getElements()
}

class BaseScreenPresenter: BaseScreenPresenterProtocol {
    
    var interactor: BaseScreenInteractorProtocol?
    var view: BaseScreenViewControllerProtocol?
    var router: BaseScreenRouterProtocol?

    func addNewElementButton() {
        router?.addNewElement()
    }
    
    func getElements() {
        let result = interactor?.getElements()
        view?.update(with: result!)
    }
    
    func elementDetailsClicked(row: Int) {
        router?.elementDetails(row: row)
    }
    
    func deletePickedElement(indexPath: Int) {
        interactor?.deleteElement(indexPath: indexPath)
        let result = interactor?.getElements()
        view?.update(with: result!)
    }
    
}
