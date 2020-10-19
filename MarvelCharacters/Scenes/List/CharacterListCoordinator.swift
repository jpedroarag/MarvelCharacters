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
        viewModel.coordinatorDelegate = self
        viewModel.fetch(with: request)
        rootNavigationController.setViewControllers([controller], animated: false)
    }
    
    override func finish() {}
    
}

extension CharacterListCoordinator: CharacterListViewModelCoordinatorDelegate {
    
    func didSelect(_ character: Character, from controller: UIViewController) {
        let image = viewModel.imagesDict[character.id]
        let detailsViewModel = CharacterDetailsViewModel(image: image ?? UIImage(),
                                                         description: character.description)
        let detailsController = CharacterDetailsViewController(viewModel: detailsViewModel)
        detailsController.navigationItem.title = character.name
        rootNavigationController.pushViewController(detailsController, animated: true)
    }
    
    func presentErrorAlert(with error: Error) {
        print(error.localizedDescription)
        let alert = UIAlertController.errorAlert { [weak self] in
            self?.viewModel.reload()
        }
        rootNavigationController.present(alert, animated: true)
    }
    
}
