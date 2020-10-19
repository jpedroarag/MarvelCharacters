//
//  CharacterListViewModel.swift
//  MarvelCharacters
//
//  Created by João Pedro Aragão on 16/10/20.
//

import Foundation
import UIKit

protocol CharacterListDataSourceType: AnyObject {
    
    var numberOfItems: Int { get }
    var totalOfItems: Int { get }
    var numberOfSections: Int { get }
    var hasMoreToLoad: Bool { get }
    
    func itemFor(index: Int) -> String
    func getImage(for index: Int) -> UIImage
    
}

protocol CharacterListDelegateType: AnyObject {
    
    func loadMore()
    func didSelect(item: Int, from controller: UIViewController)
    
}

protocol CharacterListViewModelType: CharacterListDataSourceType, CharacterListDelegateType {
    
    var viewDelegate: CharacterListViewDelegate? { get set }
    
}

protocol CharacterListViewModelCoordinatorDelegate: AnyObject {
    
    func didSelect(_ character: Character, from controller: UIViewController)
    
}

class CharacterListViewModel: CharacterListViewModelType {
    
    weak var coordinatorDelegate: CharacterListViewModelCoordinatorDelegate?
    weak var viewDelegate: CharacterListViewDelegate?
    
    let codableService: CodableService
    let imageService: ImageService
    
    private(set) var urlParameters: URLParameters
    private var _hasMoreToLoad: Bool = true
    
    var totalCharactersCount: Int?
    private(set) var characters: [Character] = []
    private(set) var imagesDict: [Int: UIImage] = [:]
    
    init(with service: CodableService = .init(),
         urlParameters: URLParameters = .defaults,
         imageService: ImageService = .init()) {
        self.codableService = service
        self.urlParameters = urlParameters
        self.imageService = imageService
    }
    
    func fetch<RequestType>(with request: RequestType) where RequestType: CodableRequestProtocol,
                                                             RequestType.WorkingType: Model {
        codableService.perform(request, handledResult: { [weak self] result in
            switch result {
            case .success(let response):
                self?.succededResponse(response)
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    func getImage(for index: Int) -> UIImage {
        if index < numberOfItems {
            let character = characters[index]
            if let image = imagesDict[character.id] {
                return image
            } else {
                getImage(for: index) { [weak self] image in
                    guard let self = self else { return }
                    let id = character.id
                    self.imagesDict[id] = image
                    self.viewDelegate?.reloadScene(with: [index])
                }
            }
        }
        return UIImage()
    }
    
    func getImage(for index: Int, result: @escaping (UIImage) -> Void) {
        guard index < numberOfItems else { return }
        let character = characters[index]
        let request = ImageRequest.request(from: character.thumbnail, with: .portrait_uncanny)
        imageService.perform(request, handledResult: { [weak self] image in
            DispatchQueue.main.async {
                switch image {
                case .success(let image):
                    self?.imagesDict[character.id] = image
                    result(image)
                case .failure(_):
                    break
                }
            }
        })
    }
    
    private func succededResponse<AnyModel>(_ response: Response<AnyModel>) where AnyModel: Model {
        totalCharactersCount = response.data.total
        
        let countBeforeUpdate = self.characters.count
        updateCharacters(with: response)
        updateHasMoreToLoad(with: response)
        
        let countAfterUpdate = self.characters.count
        let range = (countBeforeUpdate..<countAfterUpdate)
        updateScene(with: range)
    }
    
    private func updateScene(with indexes: Range<Int>) {
        DispatchQueue.main.async { [weak self] in
            let array = Array(indexes)
            self?.viewDelegate?.updateScene(with: array)
        }
    }
    
    private func updateCharacters<AnyModel>(with response: Response<AnyModel>) where AnyModel: Model {
        if let results = response.data.results,
           let chars = results as? [Character] {
            characters.append(contentsOf: chars)
        }
    }
    
    private func updateHasMoreToLoad<AnyModel>(with response: Response<AnyModel>) where AnyModel: Model {
        let count = response.data.count
        let limit = response.data.limit
        _hasMoreToLoad = (count == limit)
    }
    
}

extension CharacterListViewModel: CharacterListDataSourceType {
    
    var hasMoreToLoad: Bool {
        return _hasMoreToLoad
    }
    
    var numberOfItems: Int {
        return characters.count
    }
    
    var totalOfItems: Int {
        return totalCharactersCount ?? 0
    }
    
    var numberOfSections: Int {
        return 1
    }
    
    func itemFor(index: Int) -> String {
        guard index < numberOfItems else {
            return ""
        }
        return characters[index].name
    }
    
}

extension CharacterListViewModel: CharacterListDelegateType {
    
    func loadMore() {
        guard hasMoreToLoad else { return }
        let request: CodableRequest<Character>
        urlParameters.offset += 20
        request = .fetch([Character].self, urlParameters)
        fetch(with: request)
    }
    
    func didSelect(item: Int, from controller: UIViewController) {
        guard item < numberOfItems else { return }
        coordinatorDelegate?.didSelect(characters[item], from: controller)
    }
    
}
