//
//  RocketInfo.swift
//  Devskiller
//
//  Created by Muhammad Omair on 10/04/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

public struct RocketInfo: Decodable {
    public let id: String

    init(from rocketID: String?) {
        self.id = rocketID ?? "Unknown Rocket"
    }
}
