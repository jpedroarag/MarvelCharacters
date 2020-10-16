//
//  ImageError.swift
//  MarvelCharacters
//
//  Created by João Pedro Aragão on 16/10/20.
//

import Foundation

enum ImageError: Error {
    case loadError(String)
    case decodeError
}
