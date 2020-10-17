//
//  CodableRequest.swift
//  MarvelCharacters
//
//  Created by João Pedro Aragão on 16/10/20.
//

import Foundation

protocol Model: Codable {
    
    static var path: String { get }
    
}

enum CodableRequest<T: Model>: CodableRequestProtocol {
    
    typealias WorkingType = T
    
    case get(T.Type, URLParameters)
    case fetch([T].Type, URLParameters)
    
    var baseUrl: URL {
        switch self {
        case .get(_, let parameters),
             .fetch(_, let parameters):
            let url = urlAdding(parameters: parameters)
            return URL(string: url) ?? URL(fileURLWithPath: "")
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var headers: Headers {
        return ["Content-type": "application/json"]
    }
    
    var urlRequest: URLRequest {
        return .init(with: self)
    }
    
    func urlAdding(parameters: URLParameters) -> String {
        "http://gateway.marvel.com/".appending(T.path)
                                    .appending("?apikey=\(parameters.apiKey)")
                                    .appending("&hash=\(parameters.hash)")
                                    .appending("&ts=\(parameters.timeStamp)")
                                    .appending("&offset=\(parameters.offset)")
    }
    
}
