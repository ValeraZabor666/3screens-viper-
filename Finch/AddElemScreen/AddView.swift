//
//  AddingScreen.swift
//  Finch
//
//  Created by Captain Kidd on 06.07.2021.
//

import Foundation
import UIKit
import SnapKit

protocol AddingScreenViewControllerProtocol {
    var presenter: AddingScreenPresenterProtocol? { get set }
    func openGallery()
    func removeLabel()
    func pickedImage(newImage: UIImage)
    func showError(title: String, message: String, style: UIAlertController.Style)
}

class AddingScreenViewController: UIViewController, AddingScreenViewControllerProtocol, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    
    var presenter: AddingScreenPresenterProtocol?
    
    private var image = UIImageView()
    private var textField = UITextField()
    private var textView = UITextView()
    private var noImageLabel = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        setImageView()
        setReadyButton()
        setImageTap()
        setTextField()
        setTextView()
        setLabel()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setAllOrientationConstraints()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setColors()
    }
    
    private func setColors() {
        setBackground()
        if self.traitCollection.userInterfaceStyle == .dark {
            textField.backgroundColor = .darkGray
        } else {
            textField.backgroundColor = .white
        }
        if self.traitCollection.userInterfaceStyle == .dark {
            textView.backgroundColor = .darkGray
        } else {
            textView.backgroundColor = .white
        }
    }
    
    private func setAllOrientationConstraints() {
        if UIDevice.current.orientation.isLandscape {
            image.snp.removeConstraints()
            imageConstraintsLandscape()
            noImageLabel.snp.removeConstraints()
            labelConstraintsLandscape()
            textField.snp.removeConstraints()
            textFieldConstraintsLandscape()
            textView.snp.removeConstraints()
            textViewConstraintsLandscape()
        } else {
            image.snp.removeConstraints()
            imageConstraints()
            noImageLabel.snp.removeConstraints()
            labelConstraints()
            textField.snp.removeConstraints()
            textFieldConstraints()
            textView.snp.removeConstraints()
            textViewConstraints()
        }
    }
    
    private func setBackground() {
        if self.traitCollection.userInterfaceStyle == .dark {
            self.view.backgroundColor = .black
        } else {
            self.view.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
        }
    }
    
    private func setImageView() {
        self.image.backgroundColor = .lightGray
        self.image.contentMode = .scaleToFill
        self.image.layer.cornerRadius = 20
        self.image.clipsToBounds = true
        self.view.addSubview(image)
    }
    
    private func setLabel() {
        self.noImageLabel.text = "Chose image by tap"
        self.noImageLabel.textColor = .white
        self.noImageLabel.textAlignment = .center
        self.view.addSubview(noImageLabel)
    }
    
    private func setImageTap() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func imageTapped(tapGestureRecignizer: UITapGestureRecognizer) {
        presenter?.showImagePickerController()
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let newImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            presenter?.chosePicture(tappedImage: newImage)
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    private func setTextField() {
        if self.traitCollection.userInterfaceStyle == .dark {
            textField.backgroundColor = .darkGray
        } else {
            textField.backgroundColor = .white
        }
        textField.placeholder = "Add title"
        textField.borderStyle = .roundedRect
        self.view.addSubview(textField)
    }
    
    private func setTextView() {
        textView.delegate = self
        if self.traitCollection.userInterfaceStyle == .dark {
            textView.backgroundColor = .darkGray
        } else {
            textView.backgroundColor = .white
        }
        textView.autocorrectionType = .no
        textView.layer.cornerRadius = 7
        textView.font = UIFont.systemFont(ofSize: 20)
        self.view.addSubview(textView)
    }
    
    private func setReadyButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Готово",
            style: .plain,
            target: self,
            action: #selector(setReady))
    }
    
    @objc func  setReady() {
        presenter?.saveReadyButton(pic: image.image, desc: textView.text, title: textField.text)
    }
    
    private func imageConstraints() {
            image.snp.makeConstraints { maker in
                maker.top.equalToSuperview().inset(view.frame.height / 9)
                maker.centerX.equalToSuperview()
                maker.width.equalTo(200)
                maker.height.equalTo(150)
            }
    }
    
    private func imageConstraintsLandscape() {
            image.snp.makeConstraints { maker in
                maker.top.left.equalToSuperview().inset(70)
                maker.width.equalTo(200)
                maker.height.equalTo(150)
            }
    }
    
    private func labelConstraints() {
        noImageLabel.snp.makeConstraints { maker in
            maker.top.bottom.left.right.equalTo(image)
        }
    }
    
    private func labelConstraintsLandscape() {
            noImageLabel.snp.makeConstraints { maker in
                maker.top.bottom.left.right.equalTo(image)
            }
    }
    
    private func textFieldConstraints() {
        textField.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.height.equalTo(50)
            maker.top.equalTo(image).inset(170)
            maker.left.right.equalToSuperview().inset(50)
        }
    }
    
    private func textFieldConstraintsLandscape() {
        textField.snp.makeConstraints { maker in
            maker.top.equalToSuperview().inset(70)
            maker.left.equalTo(image).inset(250)
            maker.height.equalTo(50)
            maker.right.equalToSuperview().inset(70)
        }
    }
    
    private func textViewConstraints() {
        textView.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.top.equalTo(textField).inset(70)
            maker.bottom.equalToSuperview().inset(50)
            maker.left.right.equalToSuperview().inset(50)
        }
    }
    
    private func textViewConstraintsLandscape() {
        textView.snp.makeConstraints { maker in
            maker.top.equalTo(textField).inset(70)
            maker.left.equalTo(image).inset(250)
            maker.bottom.equalToSuperview().inset(50)
            maker.right.equalToSuperview().inset(70)
        }
    }
    
    //methods called in presenter
    func removeLabel() {
        self.noImageLabel.text = ""
    }
    
    func showError(title: String, message: String, style: UIAlertController.Style) {
        let alertWindow = UIAlertController(title: title, message: message, preferredStyle: style)
        
        let action = UIAlertAction(title: "ok", style: .default) { (action) in
        }
        
        alertWindow.addAction(action)
        self.present(alertWindow, animated: true, completion: nil)
    }
    
    func pickedImage(newImage: UIImage) {
        image.image = newImage
    }
    
    func openGallery() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
}
