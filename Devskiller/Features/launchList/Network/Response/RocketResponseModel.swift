//
//  RocketResponseModel.swift
//  Devskiller
//
//  Created by Muhammad Omair on 09/04/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//


import Foundation

public struct RocketResponseModel: Codable {
    
    // MARK: - Properties
    
    public let name: String
    public let type: String
    public let id: String
    
    public init(name: String, type: String, id: String) {
        self.name = name
        self.type = type
        self.id = id
    }
}
