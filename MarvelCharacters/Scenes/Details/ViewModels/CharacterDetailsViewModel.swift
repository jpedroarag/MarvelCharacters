//
//  CharacterDetailsViewModel.swift
//  MarvelCharacters
//
//  Created by João Pedro Aragão on 19/10/20.
//

import Foundation
import UIKit

protocol CharacterDetailsDataSourceType: AnyObject {
    
    var numberOfRows: Int { get }
    var numberOfSections: Int { get }
    
    func itemFor(index: Int) -> Any
    
}

protocol CharacterDetailsViewModelType: CharacterDetailsDataSourceType {}

class CharacterDetailsViewModel: CharacterDetailsViewModelType {
    
    let image: UIImage
    let description: String
    
    init(image: UIImage, description: String) {
        self.image = image
        self.description = (description == "") ? "No descrition found." : description
    }
    
}

extension CharacterDetailsViewModel: CharacterDetailsDataSourceType {
    
    var numberOfRows: Int {
        return 2
    }
    
    var numberOfSections: Int {
        return 1
    }
    
    func itemFor(index: Int) -> Any {
        if index == 0 {
            return image
        } else {
            return description
        }
    }
    
}
