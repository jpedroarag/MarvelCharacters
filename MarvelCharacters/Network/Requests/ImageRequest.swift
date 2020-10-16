//
//  ImageRequest.swift
//  MarvelCharacters
//
//  Created by João Pedro Aragão on 16/10/20.
//

import Foundation
import UIKit

struct ImageRequest: ImageRequestProtocol {
    
    typealias WorkingType = UIImage
    
    var baseUrl: URL
    var method: HTTPMethod
    var headers: Headers
    
    var urlRequest: URLRequest {
        return .init(with: self)
    }

    init(url: URL, method: HTTPMethod) {
        self.baseUrl = url
        self.method = method
        self.headers = ["Content-type": "application/json"]
    }
    
}
