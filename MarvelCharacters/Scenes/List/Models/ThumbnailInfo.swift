//
//  Thumbnail.swift
//  MarvelCharacters
//
//  Created by João Pedro Aragão on 18/10/20.
//

import Foundation

struct ThumbnailInfo: Codable {
    
    let path: String
    let format: String
    
    private enum CodingKeys: String, CodingKey {
        case path
        case format = "extension"
    }
    
}
