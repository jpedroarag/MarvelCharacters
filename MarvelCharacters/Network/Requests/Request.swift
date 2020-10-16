//
//  Request.swift
//  MarvelCharacters
//
//  Created by João Pedro Aragão on 16/10/20.
//

import Foundation
import UIKit

protocol Request {
    
    typealias Headers = [String: String]
    
    var baseUrl: URL { get }
    var method: HTTPMethod { get }
    var headers: Headers { get }
    var urlRequest: URLRequest { get }
    
}

protocol CodableRequestProtocol: Request {
    
    associatedtype WorkingType: Codable
    
}

protocol ImageRequestProtocol: Request {
    
    associatedtype WorkingType: UIImage
    
}
