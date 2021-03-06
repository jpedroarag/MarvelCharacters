//
//  Character.swift
//  MarvelCharacters
//
//  Created by João Pedro Aragão on 16/10/20.
//

import Foundation

struct Character: Model {
    
    static var path: String = "v1/public/characters"
    
    let id: Int
    let name: String
    let description: String
    let thumbnail: ThumbnailInfo
    
}
