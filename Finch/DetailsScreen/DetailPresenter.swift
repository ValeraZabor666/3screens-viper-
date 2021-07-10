//
//  DetailPresenter.swift
//  Finch
//
//  Created by Captain Kidd on 08.07.2021.
//

import Foundation

protocol DetailScreenPresenterProtocol {
    var router: DetailScreenRouterProtocol? { get set }
    var interactor: DetailScreenInteractorProtocol? { get set }
    var view: DetailScreenViewControllerProtocol? { get set }
    func getRowDetails(row: Int)
}

class DetailScreenPresenter: DetailScreenPresenterProtocol {
    var router: DetailScreenRouterProtocol?
    
    var interactor: DetailScreenInteractorProtocol?
    
    var view: DetailScreenViewControllerProtocol?
    
    func getRowDetails(row: Int) {
        let elem = interactor?.getElem(row: row)
        view?.updateDetails(elem: elem!)
    }
}
