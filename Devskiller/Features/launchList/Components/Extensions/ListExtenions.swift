//
//  ListExtenions.swift
//  Devskiller
//
//  Created by Muhammad Omair on 11/04/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//
import UIKit

extension LaunchRequestModel.Query: CustomStringConvertible {
    var description: String {
        return "Query with filters: [your field values here]"
    }
}

extension LaunchRequestModel.DataOptions: CustomStringConvertible {
    var description: String {
        return """
        DataOptions:
        Populate: \(populate),
        Sort: \(sort),
        Page: \(page),
        Limit: \(limit)
        """
    }
}

extension LaunchRequestModel.DataOptions.Populate: CustomStringConvertible {
    var description: String {
        return "Populate path: \(path), select: \(select)"
    }
}

extension LaunchRequestModel.DataOptions.Sort: CustomStringConvertible {
    var description: String {
        return "Sort by dateUTC: \(date_utc)"
    }
}
