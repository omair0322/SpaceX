//
//  FilterCriteria.swift
//  Devskiller
//
//  Created by Muhammad Omair on 09/04/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation

struct FilterCriteria {
    var year: String?
    var status: LaunchStatus = .all
    var isAscending: Bool = true

    func createQuery() -> LaunchRequestModel.Query {
        var queryParameters = [String: Any]()
        
        if let year = year {
            let dateRange = DateRange.fromYear(year).range()
            queryParameters["date_utc"] = ["$gte": dateRange.gte, "$lte": dateRange.lte]
        }
        
        switch status {
        case .success:
            queryParameters["success"] = true
        case .failed:
            queryParameters["success"] = false
        case .all:
            break
        }
        return LaunchRequestModel.Query(parameters: queryParameters)
    }
}
