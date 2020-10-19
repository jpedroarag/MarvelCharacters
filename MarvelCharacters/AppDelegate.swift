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
        
        let navigationController = UINavigationController()
        navigationController.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.appText as Any]
        navigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.appText as Any]
        navigationController.navigationBar.tintColor = UIColor.appText
        
        let coordinator = AppCoordinator(window: window, rootNavigationController: navigationController)
        let characterListCoordinator = CharacterListCoordinator(with: navigationController)
        
        appCoordinator = coordinator
        coordinator.addChildCoordinator(characterListCoordinator)
        
        appCoordinator?.start()
        characterListCoordinator.start()
        
        return true
    }


}

