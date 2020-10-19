//
//  CharacterDetailsViewController.swift
//  MarvelCharacters
//
//  Created by João Pedro Aragão on 19/10/20.
//

import UIKit

class CharacterDetailsViewController: UIViewController {

    let viewModel: CharacterDetailsViewModelType
    
    lazy var tableView: UITableView = .characterDetailsTableView
    
    init(viewModel: CharacterDetailsViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        navigationController?.navigationBar.prefersLargeTitles = false
        tableView.dataSource = self
        tableView.backgroundColor = .appBackground
        view = tableView
    }

    required init?(coder: NSCoder) {
        viewModel = CharacterDetailsViewModel(image: UIImage(), description: "")
        super.init(coder: coder)
    }
    
}

extension CharacterDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            return imageCell(in: tableView, at: indexPath)
        } else {
            return descritionCell(in: tableView, at: indexPath)
        }
    }
    
    private func imageCell(in tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell",
                                                       for: indexPath) as? ImageTableViewCell else {
            return .init()
        }
        cell.customImageView.image = viewModel.itemFor(index: indexPath.row) as? UIImage
        return cell
    }
    
    private func descritionCell(in tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = viewModel.itemFor(index: indexPath.row) as? String
        cell.textLabel?.textColor = UIColor.appText
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        return cell
    }
    
}
