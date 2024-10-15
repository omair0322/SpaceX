//
//  Request.swift
//  Devskiller
//
//  Created by Muhammad Omair on 09/04/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation
// MARK: - Coding Keys Enums

enum DateRangeCodingKeys: String, CodingKey {
    case gte = "$gte"
    case lte = "$lte"
}

enum QueryCodingKeys: String, CodingKey {
    case dateUTC = "date_utc"
    case success
}

enum SortCodingKeys: String, CodingKey {
    case dateUTC = "date_utc"
}
