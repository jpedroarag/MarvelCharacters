//
//  CharacterListViewModel.swift
//  MarvelCharacters
//
//  Created by João Pedro Aragão on 16/10/20.
//

import Foundation
import UIKit

protocol CharacterListViewModelType: AnyObject {
    
    var viewDelegate: CharacterListViewDelegate? { get set }
        
    var numberOfItems: Int { get }
    var totalOfItems: Int { get }
    var numberOfSections: Int { get }
    func itemFor(index: Int) -> String
    
    func loadMore()
    func didSelect(item: Int, from controller: UIViewController)
    
}

class CharacterListViewModel {
    
    var viewDelegate: CharacterListViewDelegate?
    let service: CodableService
    
    private(set) var urlParameters: URLParameters
    private(set) var hasMoreToLoad: Bool = true
    
    var totalCharactersCount: Int?
    private(set) var characters: [Character] = []
    
    init(with service: CodableService, urlParameters: URLParameters = .defaults) {
        self.service = service
        self.urlParameters = urlParameters
    }
    
    func fetch<RequestType>(with request: RequestType) where RequestType: CodableRequestProtocol,
                                                             RequestType.WorkingType: Model {
        service.perform(request, handledResult: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.succededResponse(response)
            case .failure(let error):
                print(error.localizedDescription)
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
        hasMoreToLoad = (count == limit)
    }
    
}

extension CharacterListViewModel: CharacterListViewModelType {
    
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
            return "Loading..."
        }
        return characters[index].name
    }
    
    func loadMore() {
        guard hasMoreToLoad else { return }
        let request: CodableRequest<Character>
        urlParameters.offset += 20
        request = .fetch([Character].self, urlParameters)
        fetch(with: request)
    }
    
    func didSelect(item: Int, from controller: UIViewController) {
        
    }
    
}
