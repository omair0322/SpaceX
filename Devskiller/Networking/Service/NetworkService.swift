//
//  NetworkService.swift
//  Devskiller
//
//  Created by Muhammad Omair on 09/04/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//
import Foundation
import Combine
import Alamofire

class NetworkService: NetworkServiceProtocol {
    
    init() {}

    func fetch<T: Decodable>(_ type: T.Type, from request: URLRequest) -> AnyPublisher<T, NetworkError> {
        print("Request:")
        request.prettyPrintRequest()

        return Future<T, NetworkError> { promise in
            AF.request(request)
                .validate()  // Validates the status code (200-299)
                .responseData { response in
                    if let statusCode = response.response?.statusCode {
                        print("Status Code: \(statusCode)")
                    }
                    if let headers = response.response?.allHeaderFields {
                        print("Response Headers: \(headers)")
                    }

                    switch response.result {
                    case .success(let data):
                        if let responseString = String(data: data, encoding: .utf8) {
                            print("Raw Response: \(responseString)")
                        }

                        do {
                            let decodedData = try JSONDecoder().decode(T.self, from: data)
                            promise(.success(decodedData))

                        } catch let decodingError as DecodingError {
                            self.logDetailedDecodingError(data: data, error: decodingError, type: T.self)

                            promise(.failure(.decodingFailed("Failed to decode JSON response: \(decodingError.localizedDescription)")))
                        } catch {
                            print("Unknown Decoding Error: \(error.localizedDescription)")
                            promise(.failure(.unknown("Unknown error during decoding: \(error.localizedDescription)")))
                        }

                    case .failure(let error):
                        self.logNetworkError(response: response)

                        promise(.failure(.networkError(error.localizedDescription)))
                    }
                }
        }
        .eraseToAnyPublisher()
    }


    private func logDetailedDecodingError<T: Decodable>(data: Data, error: DecodingError, type: T.Type) {
        if let responseString = String(data: data, encoding: .utf8) {
            print("Decoding Error: Failed to decode response: \(responseString)")
        }
        
        switch error {
        case .typeMismatch(let type, let context):
            print("Type Mismatch Error: \(type) \(context.debugDescription) at codingPath: \(context.codingPath)")
        case .valueNotFound(let type, let context):
            print("Value Not Found Error: \(type) \(context.debugDescription) at codingPath: \(context.codingPath)")
        case .keyNotFound(let key, let context):
            print("Key Not Found Error: \(key.stringValue) \(context.debugDescription) at codingPath: \(context.codingPath)")
        case .dataCorrupted(let context):
            print("Data Corrupted Error: \(context.debugDescription) at codingPath: \(context.codingPath)")
        @unknown default:
            print("Unknown Decoding Error: \(error.localizedDescription)")
        }
    }
    
    private func logNetworkError(response: AFDataResponse<Data>) {
        if let data = response.data, let responseString = String(data: data, encoding: .utf8) {
            print("Server responded with error: \(responseString)")
        }
        if let error = response.error {
            print("Network error: \(error.localizedDescription)")
        }
    }
}
