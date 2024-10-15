//
//  APIError.swift
//  Devskiller
//
//  Created by Muhammad Omair on 09/04/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation
enum APIError: Error {
    case invalidURL
    case requestFailed(String)
    case networkError(String)
}
