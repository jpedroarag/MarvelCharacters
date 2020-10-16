//
//  URLParameters.swift
//  MarvelCharacters
//
//  Created by João Pedro Aragão on 16/10/20.
//

import Foundation

struct URLParameters {
    
    let apiKey: String
    let hash: String
    let timeStamp: Int
    let offset: Int
    
}

extension URLParameters {
    
    static var defaults: URLParameters {
        return URLParameters(apiKey: "cbd7280a7cf410f7abc925444020a533",
                             hash: "8d6c2d272f96dc3675d0dc805acb4b71",
                             timeStamp: 1,
                             offset: 0)
    }
    
}
