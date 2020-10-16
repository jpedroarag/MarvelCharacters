//
//  URLRequestExtension.swift
//  MarvelCharacters
//
//  Created by João Pedro Aragão on 16/10/20.
//

import Foundation

extension URLRequest {
    
    init<T: Request>(with service: T) {
        self.init(url: service.baseUrl)
        self.httpMethod = service.method.rawValue
        service.headers.forEach { key, value in
            self.addValue(value, forHTTPHeaderField: key)
        }
    }
    
}
