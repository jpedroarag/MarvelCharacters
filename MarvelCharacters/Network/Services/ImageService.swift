//
//  ImageService.swift
//  MarvelCharacters
//
//  Created by João Pedro Aragão on 16/10/20.
//

import Foundation
import UIKit

class ImageService: DataProvider, ImageProvider {

    func perform<T>(_ request: T,
                    handledResult: @escaping (Result<T.WorkingType, Error>) -> Void) where T: ImageRequestProtocol {
        perform(request, dataResult: { result in
            switch result {
            case .success(let data):
                guard let image = UIImage(data: data) as? T.WorkingType else {
                    return handledResult(.failure(ImageError.decodeError))
                }
                handledResult(.success(image))
            case .failure(let error):
                let description = error.localizedDescription
                let imageError = ImageError.loadError(description)
                handledResult(.failure(imageError))
            }
        })
    }

}
