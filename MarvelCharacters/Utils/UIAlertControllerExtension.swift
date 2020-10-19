//
//  PlaceholderAlert.swift
//  MarvelCharacters
//
//  Created by João Pedro Aragão on 19/10/20.
//

import UIKit

extension UIAlertController {
    
    static func alert(withTitle title: String,
                      message: String,
                      style: UIAlertController.Style = .alert,
                      actions: [UIAlertAction]) -> UIAlertController {
        let controller = UIAlertController(title: title, message: message, preferredStyle: style)
        actions.forEach { controller.addAction($0) }
        return controller
    }
    
    static func alert(withTitle title: String,
                      message: String,
                      style: UIAlertController.Style = .alert,
                      actions: UIAlertAction...) -> UIAlertController {
        return .alert(withTitle: title, message: message, actions: actions)
    }

    static func errorAlert(tryAgainAction: (() -> Void)? = nil) -> UIAlertController {
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let reloadAction = UIAlertAction(title: "Reload", style: .default) { _ in
            tryAgainAction?()
        }
        return .alert(withTitle: "Error",
                      message: "Do you want to reload it?",
                      actions: cancelAction,
                                reloadAction)
    }
    
}
