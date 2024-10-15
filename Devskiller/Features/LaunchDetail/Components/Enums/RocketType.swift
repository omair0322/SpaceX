//
//  RocketType.swift
//  Devskiller
//
//  Created by Muhammad Omair on 10/04/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

enum RocketType: String {
    case falconHeavy = "Falcon Heavy"
    case falcon9 = "Falcon 9"
    case starship = "Starship"
    case unknown = "Unknown Type"

    init(from type: String?) {
        switch type {
        case "Falcon Heavy":
            self = .falconHeavy
        case "Falcon 9":
            self = .falcon9
        case "Starship":
            self = .starship
        default:
            self = .unknown
        }
    }
}
