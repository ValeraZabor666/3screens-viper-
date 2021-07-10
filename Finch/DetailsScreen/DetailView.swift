//
//  DetailView.swift
//  Finch
//
//  Created by Captain Kidd on 08.07.2021.
//

import Foundation
import UIKit

protocol DetailScreenViewControllerProtocol {
    var presenter: DetailScreenPresenterProtocol? { get set }
    func updateDetails(elem: Element)
}

class DetailScreenViewController: UIViewController, DetailScreenViewControllerProtocol {
    
    var presenter: DetailScreenPresenterProtocol?
    
    private var image = UIImageView()
    private var titleLabel = UILabel()
    private var textLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setImage()
        setTitle()
        setDescription()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setAllOrientationConstraints()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setColors()
    }
    
    private func setColors() {
        setUpView()
        if self.traitCollection.userInterfaceStyle == .dark {
            titleLabel.backgroundColor = .darkGray
        } else {
            titleLabel.backgroundColor = .white
        }
        if self.traitCollection.userInterfaceStyle == .dark {
            textLabel.backgroundColor = .darkGray
        } else {
            textLabel.backgroundColor = .white
        }
    }
    
    private func setAllOrientationConstraints() {
        if UIDevice.current.orientation.isLandscape {
            image.snp.removeConstraints()
            imageConstraintsLandscape()
            titleLabel.snp.removeConstraints()
            textFieldConstraintsLandscape()
            textLabel.snp.removeConstraints()
            textViewConstraintsLandscape()
        } else {
            image.snp.removeConstraints()
            imageConstraints()
            titleLabel.snp.removeConstraints()
            textFieldConstraints()
            textLabel.snp.removeConstraints()
            textViewConstraints()
        }
    }
    
    private func setUpView() {
        if self.traitCollection.userInterfaceStyle == .dark {
            self.view.backgroundColor = .black
        } else {
            self.view.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
        }
    }
    
    private func setImage() {
        self.image.backgroundColor = .lightGray
        image.contentMode = .scaleToFill
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
        self.view.addSubview(image)
    }
    
    private func setTitle() {
        if self.traitCollection.userInterfaceStyle == .dark {
            titleLabel.backgroundColor = .darkGray
        } else {
            titleLabel.backgroundColor = .white
        }
        titleLabel.layer.masksToBounds = true
        titleLabel.layer.cornerRadius = 7
        titleLabel.clipsToBounds = true
        titleLabel.textAlignment = .center
        self.view.addSubview(titleLabel)
    }
    
    private func setDescription() {
        if self.traitCollection.userInterfaceStyle == .dark {
            textLabel.backgroundColor = .darkGray
        } else {
            textLabel.backgroundColor = .white
        }
        textLabel.layer.masksToBounds = true
        textLabel.layer.cornerRadius = 7
        textLabel.clipsToBounds = true
        textLabel.textAlignment = .natural
        self.view.addSubview(textLabel)
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
    
    private func textFieldConstraints() {
        titleLabel.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.height.equalTo(50)
            maker.top.equalTo(image).inset(170)
            maker.left.right.equalToSuperview().inset(50)
        }
    }
    
    private func textFieldConstraintsLandscape() {
        titleLabel.snp.makeConstraints { maker in
            maker.top.equalToSuperview().inset(70)
            maker.left.equalTo(image).inset(250)
            maker.height.equalTo(50)
            maker.right.equalToSuperview().inset(70)
        }
    }
    
    private func textViewConstraints() {
        textLabel.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.top.equalTo(titleLabel).inset(70)
            maker.bottom.equalToSuperview().inset(50)
            maker.left.right.equalToSuperview().inset(50)
        }
    }
    
    private func textViewConstraintsLandscape() {
        textLabel.snp.makeConstraints { maker in
            maker.top.equalTo(titleLabel).inset(70)
            maker.left.equalTo(image).inset(250)
            maker.bottom.equalToSuperview().inset(50)
            maker.right.equalToSuperview().inset(70)
        }
    }
    
    func updateDetails(elem: Element) {
        image.image = elem.image
        titleLabel.text = elem.title
        textLabel.text = "Description" + ": " + elem.description
        self.title = elem.title
    }
    
}
