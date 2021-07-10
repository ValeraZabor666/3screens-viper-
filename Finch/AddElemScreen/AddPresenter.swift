//
//  AddPresenter.swift
//  Finch
//
//  Created by Captain Kidd on 07.07.2021.
//

import Foundation
import UIKit

protocol AddingScreenPresenterProtocol {
    var router: AddingScreenRouterProtocol? { get set }
    var interactor: AddingScreenInteractorProtocol? { get set }
    var view: AddingScreenViewControllerProtocol? { get set }
    func saveReadyButton(pic: UIImage?, desc: String, title: String?)
    func showImagePickerController()
    func chosePicture(tappedImage: UIImage)
}

class AddingScreenPresenter: AddingScreenPresenterProtocol {
    var router: AddingScreenRouterProtocol?
    var interactor: AddingScreenInteractorProtocol?
    var view: AddingScreenViewControllerProtocol?
    
    func saveReadyButton(pic: UIImage?, desc: String, title: String?) {
        if pic == nil || desc.isEmpty || title!.isEmpty {
            if pic == nil {
                view?.showError(title: "No picture", message: "Chose picture", style: .alert)
            } else if title!.isEmpty {
                view?.showError(title: "No title", message: "Create title", style: .alert)
            } else {
                view?.showError(title: "No desription", message: "Write description", style: .alert)
            }
        }
        else {
            let element = Element(image: pic!, title: title!, description: desc)
            interactor?.addElelment(element: element)
            router?.backToBase()
        }
    }
    
    func showImagePickerController() {
        view?.openGallery()
    }
    
    func chosePicture(tappedImage: UIImage) {
        view?.pickedImage(newImage: tappedImage)
        view?.removeLabel()
    }
    
}
