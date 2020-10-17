//
//  Response.swift
//  MarvelCharacters
//
//  Created by João Pedro Aragão on 17/10/20.
//

import Foundation

struct Response<T>: Codable where T: Model {
    
    let code: Int
    let message: String?
    let data: [String: Any]?
    
    var count: Int? {
        return data?["count"] as? Int
    }
    
    var limit: Int? {
        return data?["limit"] as? Int
    }
    
    var result: T? {
        guard let data = data,
              let result = data["results"],
              let resultData = try? JSONSerialization.data(withJSONObject: result,
                                                           options: []) else {
            return nil
        }
        return try? JSONDecoder().decode(T.self, from: resultData)
    }
    
    var results: [T]? {
        guard let data = data,
              let results = data["results"],
              let resultsData = try? JSONSerialization.data(withJSONObject: results,
                                                           options: []) else {
            return nil
        }
        return try? JSONDecoder().decode([T].self, from: resultsData)
    }
    
    enum CodingKeys: String, CodingKey {
        case code
        case message
        case data
        case attributionHTML
        case attributionText
        case copyright
        case etag
        case status
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decode(Int.self, forKey: .code)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decode([String:Any].self, forKey: .data)
    }

    func encode(to encoder: Encoder) throws {}
    
}
