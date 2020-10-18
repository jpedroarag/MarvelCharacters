//
//  Response.swift
//  MarvelCharacters
//
//  Created by João Pedro Aragão on 17/10/20.
//

import Foundation

struct ResponseData<T>: Codable where T: Model {
    
    let total: Int
    let count: Int
    let limit: Int
    let result: T?
    let results: [T]?
    
}

struct Response<T>: Codable where T: Model {
    
    let code: Int
    let message: String?
    let data: ResponseData<T>
    
}
