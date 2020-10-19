//
//  CharacterListCoordinator.swift
//  MarvelCharacters
//
//  Created by João Pedro Aragão on 16/10/20.
//

import UIKit

class CharacterListCoordinator: Coordinator {
    
    let service: CodableService
    let rootNavigationController: UINavigationController
    let viewModel: CharacterListViewModel
    let title: String
    
    init(with rootNavigationController: UINavigationController,
         title: String = "Characters",
         service: CodableService = .init()) {
        self.rootNavigationController = rootNavigationController
        self.title = title
        self.service = service
        self.viewModel = CharacterListViewModel(with: service, urlParameters: URLParameters.defaults)
        super.init()
    }
    
    override func start() {
        let controller = CharacterListViewController(viewModel: viewModel)
        let request = CodableRequest.fetch([Character].self, .defaults)
        controller.navigationItem.title = title
        viewModel.fetch(with: request)
        rootNavigationController.setViewControllers([controller], animated: false)
    }
    
    override func finish() {}
    
}
