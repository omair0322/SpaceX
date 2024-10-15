//
//  Launch.swift
//  Devskiller
//
//  Created by Muhammad Omair on 09/04/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation

public enum LaunchStatus: String, Codable, CaseIterable {
    case all = "All"
    case success = "Success"
    case failed = "Failed"
    
    var displayName: String {
        switch self {
        case .all:
            return "All"
        case .success:
            return "Success"
        case .failed:
            return "Failed"
        }
    }
    
    var apiParameter: String? {
        switch self {
        case .all:
            return nil 
        case .success:
            return "success"
        case .failed:
            return "failed"
        }
    }


    init(fromSuccessValue: Bool?) {
        switch fromSuccessValue {
        case true:
            self = .success
        case false:
            self = .failed
        default:
            self = .all
        }
    }
}
