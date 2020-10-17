//
//  JSONCodingKeys.swift
//  MarvelCharacters
//
//  Created by João Pedro Aragão on 17/10/20.
//

import Foundation

struct JSONCodingKeys: CodingKey {
    
    var stringValue: String

    init?(stringValue: String) {
        self.stringValue = stringValue
    }

    var intValue: Int?

    init?(intValue: Int) {
        self.init(stringValue: "\(intValue)")
        self.intValue = intValue
    }
    
}
