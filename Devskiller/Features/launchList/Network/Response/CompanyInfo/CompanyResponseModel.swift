//
//  CompanyResponseModel.swift
//  Devskiller
//
//  Created by Muhammad Omair on 09/04/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation
public struct CompanyResponseModel: Codable {
    
    // MARK: - Properties
    
    public var name: String
    public var founder: String
    public var founded: Int
    public var employees: Int
    public var launchSites: Int
    public var valuation: Int64
    public var id: String
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String, CodingKey {
        case name
        case founder
        case founded
        case employees
        case launchSites = "launch_sites"
        case valuation
        case id
    }
    
    public init(name: String, founder: String, founded: Int, employees: Int, launchSites: Int, valuation: Int64, id: String) {
        self.name = name
        self.founder = founder
        self.founded = founded
        self.employees = employees
        self.launchSites = launchSites
        self.valuation = valuation
        self.id = id
    }
}
