//
//  Provider.swift
//  MarvelCharacters
//
//  Created by João Pedro Aragão on 16/10/20.
//

import Foundation

protocol SessionProvider {
    
    var session: URLSession { get }
    
}

class DataProvider: SessionProvider {
    
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func perform<T>(_ request: T,
                    dataResult: @escaping (Result<Data, Error>) -> Void) where T: Request {
        session.dataTask(with: request.urlRequest) { data, response, error in
            guard response != nil,
                  let data = data else {
                return dataResult(.failure(NetworkError.noJSONData))
            }
            dataResult(.success(data))
        }.resume()
    }
    
}

protocol CodableProvider: DataProvider {
    
    func perform<T>(_ request: T,
                    handledResult: @escaping (Result<T.WorkingType, Error>) -> Void) where T: CodableRequestProtocol
    
}

protocol ImageProvider: DataProvider {
    
    func perform<T>(_ request: T,
                    handledResult: @escaping (Result<T.WorkingType, Error>) -> Void) where T: ImageRequestProtocol
    
}
