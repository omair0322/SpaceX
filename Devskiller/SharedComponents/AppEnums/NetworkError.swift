//
//  NetworkError.swift
//  Devskiller
//
//  Created by Muhammad Omair on 09/04/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation

enum NetworkError: Error, CustomStringConvertible, Equatable {
    case requestFailed(String)
    case invalidData(String)
    case decodingFailed(String)
    case networkError(String)
    case unknown(String)
    case databaseOperationFailed(String)

    var description: String {
        switch self {
        case .requestFailed(let message):
            return "Request Failed: \(message)"
        case .invalidData(let message):
            return "Invalid Data: \(message)"
        case .decodingFailed(let message):
            return "Decoding Error: \(message)"
        case .networkError(let message):
            return "Network Error: \(message)"
        case .unknown(let message):
            return "Unknown Error: \(message)"
        case .databaseOperationFailed(let message):
            return "Database Operation Failed: \(message)"
        }
    }

    // MARK: - Equatable Conformance
    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        return lhs.description == rhs.description
    }
}
