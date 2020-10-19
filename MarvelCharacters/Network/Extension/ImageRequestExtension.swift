//
//  ImageRequestExtension.swift
//  MarvelCharacters
//
//  Created by João Pedro Aragão on 18/10/20.
//

import Foundation

extension ImageRequest {
    
    static func request(from thumbnail: ThumbnailInfo, with type: ThumbnailType) -> ImageRequest {
        let typeValue = (type != .fullSize) ? "/\(type.rawValue)" : ""
        let urlString = "\(thumbnail.path)" + typeValue + ".\(thumbnail.format)"
        let url = URL(string: urlString) ?? URL(fileURLWithPath: "")
        let request = ImageRequest(url: url, method: .get)
        return request
    }
    
}
