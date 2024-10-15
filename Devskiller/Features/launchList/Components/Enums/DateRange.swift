//
//  DateRange.swift
//  Devskiller
//
//  Created by Muhammad Omair on 09/04/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//
import Foundation

enum DateRange {
    case year(String)
    case custom(String, String)
    case `default`

    static func fromYear(_ year: String?) -> DateRange {
        if let year = year {
            return .year(year)
        } else {
            return .default
        }
    }

    func range() -> (gte: String, lte: String) {
        switch self {
        case .year(let year):
            return (gte: "\(year)-01-01", lte: "\(year)-12-31")
        case .custom(let startDate, let endDate):
            return (gte: startDate, lte: endDate)
        case .default:
            return (gte: "0000-01-01", lte: "9999-12-31")
        }
    }
}
