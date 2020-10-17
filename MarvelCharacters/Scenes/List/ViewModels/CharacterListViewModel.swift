//
//  CharacterListViewModel.swift
//  MarvelCharacters
//
//  Created by João Pedro Aragão on 16/10/20.
//

import Foundation

class CharacterListViewModel {
    
    let service: CodableService
    
    private(set) var urlParameters: URLParameters
    private(set) var hasMoreToLoad: Bool = true
    
    init(with service: CodableService, urlParameters: URLParameters = .defaults) {
        self.service = service
        self.urlParameters = urlParameters
    }
    
    func fetch<RequestType>(with request: RequestType) where RequestType: CodableRequestProtocol,
                                                             RequestType.WorkingType: Model {
        guard hasMoreToLoad else { return }
        service.perform(request, handledResult: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.updateCharacters(with: response)
                self.updateHasMoreToLoad(with: response)
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    func loadMore() {
        let request: CodableRequest<Character>
        urlParameters.offset += 20
        request = .fetch([Character].self, urlParameters)
        fetch(with: request)
    }
    
    private func updateCharacters<AnyModel>(with response: Response<AnyModel>) where AnyModel: Model {
        if let characters = response.results {
            print(characters)
        }
    }
    
    private func updateHasMoreToLoad<AnyModel>(with response: Response<AnyModel>) where AnyModel: Model {
        guard let count = response.count,
              let limit = response.limit else {
            return
        }
        hasMoreToLoad = (count == limit)
    }
    
}
