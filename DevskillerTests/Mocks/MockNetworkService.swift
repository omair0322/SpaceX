//
//  MockNetworkService.swift
//  DevskillerTests
//
//  Created by Muhammad Omair on 11/04/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Alamofire
import Combine
import Foundation
@testable import Devskiller

class MockNetworkService: NetworkServiceProtocol {
    
    var mockResponse: Result<Data, NetworkError>?
    
    func fetch<T: Decodable>(_ type: T.Type, from request: URLRequest) -> AnyPublisher<T, NetworkError> {
        return Future { promise in
            if let mockResponse = self.mockResponse {
                switch mockResponse {
                case .success(let data):
                    do {
                        let decodedData = try JSONDecoder().decode(T.self, from: data)
                        promise(.success(decodedData))
                    } catch {
                        promise(.failure(NetworkError.decodingFailed("Decoding failed: \(error.localizedDescription)")))
                    }
                case .failure(let error):
                    promise(.failure(error))
                }
            } else {
                promise(.failure(NetworkError.unknown("No mock response set")))
            }
        }
        .eraseToAnyPublisher()
    }
}
