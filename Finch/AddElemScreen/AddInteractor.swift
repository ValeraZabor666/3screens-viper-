//
//  AddInteractor.swift
//  Finch
//
//  Created by Captain Kidd on 07.07.2021.
//

import Foundation
import UIKit

protocol AddingScreenInteractorProtocol {
    var presenter: AddingScreenPresenterProtocol? { get set }
    var entity: ElementEntity? { get set }
    func addElelment(element: Element)
}

class AddingScreenInteractor: ElementEntity, AddingScreenInteractorProtocol {

    var presenter: AddingScreenPresenterProtocol?
    var entity: ElementEntity?
    

    func addElelment(element: Element) {
        ElementEntity.sharedEntity.elements.append(element)
    }
    
}

