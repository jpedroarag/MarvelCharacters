//
//  Character.swift
//  MarvelCharacters
//
//  Created by João Pedro Aragão on 16/10/20.
//

import Foundation

struct Thumbnail: Codable {
    
    let path: String
    let format: String
    
    private enum CodingKeys: String, CodingKey {
        case path
        case format = "extension"
    }
    
}

struct Character: Model {
    
    static var path: String = "v1/public/characters"
    
    let id: Int
    let description: String
    let thumbnail: Thumbnail
    
}
