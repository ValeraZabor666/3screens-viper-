//
//  DetailInteractor.swift
//  Finch
//
//  Created by Captain Kidd on 08.07.2021.
//

import Foundation

protocol DetailScreenInteractorProtocol {
    var presenter: DetailScreenPresenterProtocol? { get set }
    
    func getElem(row: Int) -> Element
}

class DetailScreenInteractor: DetailScreenInteractorProtocol {
    var presenter: DetailScreenPresenterProtocol?
    
    func getElem(row: Int) -> Element {
        let element = ElementEntity.sharedEntity.elements[row]
        return element
    }
}
