//
//  NetworkError.swift
//  MarvelCharacters
//
//  Created by João Pedro Aragão on 16/10/20.
//

import Foundation

enum NetworkError: Error {
    case unknown
    case clientError(statusCode: Int, dataResponse: String)
    case serverError(statusCode: Int, dataResponse: String)
    case decodeError(String)
    case noJSONData
}
