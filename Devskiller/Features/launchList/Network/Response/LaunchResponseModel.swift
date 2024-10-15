//
//  LaunchResponseModel.swift
//  Devskiller
//
//  Created by Muhammad Omair on 09/04/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation

public struct LaunchResponseModel: Decodable {
    public let docs: [LaunchModel]
}

public struct LaunchModel: Decodable {
    
    // MARK: - Properties
    
    public let id: String
    public let name: String
    public let dateUtc: String
    public var success: Bool?
    public let rocket: RocketResponseModel
    public let links: LinksResponseModel
    
  
    public init(
        id: String,
        name: String,
        dateUtc: String,
        success: Bool?,
        rocket: RocketResponseModel,
        links: LinksResponseModel
    ) {
        self.id = id
        self.name = name
        self.dateUtc = dateUtc
        self.success = success
        self.rocket = rocket
        self.links = links
    }

    // MARK: - CodingKeys
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case dateUtc = "date_utc"
        case success
        case rocket
        case links
    }
}


