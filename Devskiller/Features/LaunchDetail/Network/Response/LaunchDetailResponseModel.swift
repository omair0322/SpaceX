//
//  LaunchDetailResponseModel.swift
//  Devskiller
//
//  Created by Muhammad Omair on 10/04/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation

public struct LaunchDetailResponseModel: Decodable {
    
    // MARK: - Properties
    public let id: String
    public let name: String
    public let dateUTC: String
    public let status: LaunchStatus
    public let rocket: RocketInfo
    public let links: LinksResponseModel?
    public let details: String?
    
    // MARK: - Initializer
    
    public init(
        id: String,
        name: String,
        dateUTC: String,
        status: LaunchStatus,
        rocket: RocketInfo,
        links: LinksResponseModel?,
        details: String?
    ) {
        self.id = id
        self.name = name
        self.dateUTC = dateUTC
        self.status = status
        self.rocket = rocket
        self.links = links
        self.details = details
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.dateUTC = try container.decode(String.self, forKey: .dateUTC)
        
        let successValue = try container.decodeIfPresent(Bool.self, forKey: .success)
        self.status = LaunchStatus(fromSuccessValue: successValue) 
        
        let rocketName = try container.decodeIfPresent(String.self, forKey: .rocket)
        self.rocket = RocketInfo(from: rocketName)
        
        self.links = try container.decodeIfPresent(LinksResponseModel.self, forKey: .links)
        self.details = try container.decodeIfPresent(String.self, forKey: .details)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case dateUTC = "date_utc"
        case success
        case rocket
        case links
        case details
    }
}
