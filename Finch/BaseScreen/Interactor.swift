//
//  Interactor.swift
//  Finch
//
//  Created by Captain Kidd on 06.07.2021.
//

import Foundation

protocol BaseScreenInteractorProtocol {
    var presenter: BaseScreenPresenterProtocol? { get set }
    var entity: ElementEntity? { get set }
    func getElements() -> [Element]
    func deleteElement(indexPath: Int)
}

class BaseScreenInteractor: BaseScreenInteractorProtocol {
    
    var entity: ElementEntity?
    var presenter: BaseScreenPresenterProtocol?
    
    func getElements() -> [Element] {
        return ElementEntity.sharedEntity.elements
    }
    
    func deleteElement(indexPath: Int) {
        ElementEntity.sharedEntity.elements.remove(at: indexPath)
    }
    
}
