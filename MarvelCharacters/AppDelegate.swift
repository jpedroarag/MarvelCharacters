//
//  AppDelegate.swift
//  MarvelCharacters
//
//  Created by João Pedro Aragão on 15/10/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let coordinator = AppCoordinator(window: window)
        let characterListCoordinator = CharacterListCoordinator(with: coordinator.rootNavigationController)
        
        appCoordinator = coordinator
        coordinator.addChildCoordinator(characterListCoordinator)
        
        appCoordinator?.start()
        characterListCoordinator.start()
        
        return true
    }


}

