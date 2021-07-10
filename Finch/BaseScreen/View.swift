//
//  View.swift
//  Finch
//
//  Created by Captain Kidd on 06.07.2021.
//

import Foundation
import UIKit

protocol BaseScreenViewControllerProtocol {
    var presenter: BaseScreenPresenterProtocol? { get set }
    func update(with elements: [Element])
}

class BaseScreenViewController: UIViewController, BaseScreenViewControllerProtocol, UITableViewDelegate, UITableViewDataSource, UIApplicationDelegate {
    
    var presenter: BaseScreenPresenterProtocol?
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self,
                       forCellReuseIdentifier: "cell")
        return table
    }()
    var elements: [Element] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setNavigationParams()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.getElements()
        setColors()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setColors()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func update(with elements: [Element]) {
        DispatchQueue.main.async {
            self.elements = elements
            self.tableView.reloadData()
        }
    }
    
    private func setColors() {
        if self.traitCollection.userInterfaceStyle == .dark {
            tableView.backgroundColor = .black
        } else {
            tableView.backgroundColor = UIColor(red: 0.9,
                                                green: 0.9,
                                                blue: 0.9,
                                                alpha: 1.0)
        }
        self.tableView.reloadData()
    }
    
    private func setUpView() {
        title = "Главный экран"
        self.tableView.rowHeight = 80
        self.tableView.separatorStyle = .none
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setNavigationParams() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(didTapAdd))
        navigationItem.backButtonTitle = "Назад"
    }
    
    @objc func didTapAdd() {
        presenter?.addNewElementButton()
    }
    
    
    //MARK: - table view delegate methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.subviews.forEach({ $0.removeFromSuperview() })
        if self.traitCollection.userInterfaceStyle == .dark {
            cell?.backgroundColor = .darkGray
        } else {
            cell?.backgroundColor = .white
        }
        let item = elements[indexPath.row]
        let image = UIImageView()
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
        cell?.addSubview(image)
        image.frame = CGRect(x: 5,
                             y: 5,
                             width: 100,
                             height: 70)
        let title = UILabel()
        cell?.addSubview(title)
        title.frame = CGRect(x: 120,
                             y: 5,
                             width: cell!.frame.width / 2,
                             height: 35)
        let description = UILabel()
        cell?.addSubview(description)
        description.frame = CGRect(x: 120,
                                   y: 42,
                                   width: cell!.frame.width / 2,
                                   height: 35)
        
        image.image = item.image
        title.text = item.title
        description.text = item.description
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.elementDetailsClicked(row: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            let one = indexPath.row
            presenter?.deletePickedElement(indexPath: one)
        }
    }
}
