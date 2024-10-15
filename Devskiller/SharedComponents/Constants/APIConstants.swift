//
//  APIConstants.swift
//  Devskiller
//
//  Created by Muhammad Omair on 09/04/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation

struct APIConstants {
    
    // MARK: - Base URL
    
    struct BaseURL {
        static let production = "https://api.spacexdata.com/v4"
    }
    
    // MARK: - Endpoints
    
    struct Endpoints {
        static let companyInfo = "/company"
        static let allLaunches = "/launches/query"
        static let launchDetail = "/launches"
    }
    
    // MARK: - HTTP Methods
    
    struct HTTPMethods {
        static let get = "GET"
        static let post = "POST"
    }
    
    // MARK: - Headers
    
    struct Headers {
        static let contentType = "Content-Type"
        static let contentTypeJSON = "application/json"
    }
    
    // MARK: - Query Parameters
    
    struct QueryParameters {
        static let limit = 10
        static let asc = "asc"
        static let desc = "desc"
        static let rocket = "rocket"
    }
}

