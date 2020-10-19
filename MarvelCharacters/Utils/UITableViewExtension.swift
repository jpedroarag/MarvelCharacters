//
//  UITableViewExtension.swift
//  MarvelCharacters
//
//  Created by João Pedro Aragão on 19/10/20.
//

import UIKit

extension UITableView {
    
    static var characterDetailsTableView: UITableView {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: "ImageCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UIScreen.main.bounds.height/2.5
        tableView.separatorStyle = .none
        tableView.bounces = false
        return tableView
    }
    
}
