//
//  LaunchSuccess.swift
//  Devskiller
//
//  Created by Muhammad Omair on 10/04/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

public enum LaunchSuccess {
    case success
    case failure
    case unknown
    
    init(from success: Bool?) {
        switch success {
        case true:
            self = .success
        case false:
            self = .failure
        default:
            self = .unknown
        }
    }
}
