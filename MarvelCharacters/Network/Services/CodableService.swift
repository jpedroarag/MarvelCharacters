//
//  CodableService.swift
//  MarvelCharacters
//
//  Created by João Pedro Aragão on 16/10/20.
//

import Foundation

class CodableService: DataProvider, CodableProvider {

    func perform<T>(_ request: T,
                    handledResult: @escaping (Result<T.WorkingType, Error>) -> Void) where T: CodableRequestProtocol {
        session.dataTask(with: request.urlRequest) { data, response, error in
            self.handleResult(result: (data, response, error),
                              completion: handledResult)
        }.resume()
    }
    
    private func handleResult<D: Decodable>(result: (data: Data?, response: URLResponse?, error: Error?),
                                            completion: (Result<D, Error>) -> Void) {
        guard let response = result.response else {
            return completion(.failure(NetworkError.noJSONData))
        }
        guard let data = result.data,
            let dataString = String(bytes: data, encoding: .utf8) else {
                return
        }
        guard let httpResponse = response as? HTTPURLResponse else {
            return succededResquest(data: data, completion: completion)
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            succededResquest(data: data, completion: completion)
        case 400...499:
            completion(.failure(NetworkError.clientError(statusCode: httpResponse.statusCode, dataResponse: dataString)))
        case 500...599:
            completion(.failure(NetworkError.serverError(statusCode: httpResponse.statusCode, dataResponse: dataString)))
        default:
            completion(.failure(NetworkError.unknown))
        }
        
    }
    
    private func succededResquest<D: Decodable>(data: Data, completion: (Result<D, Error>) -> Void) {
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.calendar = .init(identifier: .iso8601)
        formatter.dateFormat = "MM-dd-yy"
        decoder.dateDecodingStrategy = .formatted(formatter)
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        do {
            let model = try decoder.decode(D.self, from: data)
            completion(.success(model))
        } catch {
            completion(.failure(NetworkError.decodeError(error.localizedDescription)))
        }
    }
    
}
