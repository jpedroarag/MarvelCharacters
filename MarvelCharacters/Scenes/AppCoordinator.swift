//
//  AppCoordinator.swift
//  MarvelCharacters
//
//  Created by João Pedro Aragão on 15/10/20.
//

import UIKit

class AppCoordinator: Coordinator {
    
    let window: UIWindow?
    let rootNavigationController: UINavigationController
    
    init(window: UIWindow?,
         rootNavigationController: UINavigationController = .init()) {
        self.window = window
        self.rootNavigationController = rootNavigationController
    }

    override func start() {
        guard let window = window else {
            return
        }
        window.rootViewController = rootNavigationController
        window.makeKeyAndVisible()
    }
    
    override func finish() {}
    
}
