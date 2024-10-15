//
//  LaunchRequestModel.swift
//  Devskiller
//
//  Created by Muhammad Omair on 09/04/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation

class LaunchRequestModel: Codable {
    
    // MARK: - Properties
    
    var query: Query
    var options: DataOptions
    
    // MARK: - Query Model
    
    class Query: Codable {
        var parameters: [String: Any]
        
        init(parameters: [String: Any]) {
            self.parameters = parameters
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: DynamicCodingKeys.self)
            
            for (key, value) in parameters {
                switch value {
                case let stringValue as String:
                    try container.encode(stringValue, forKey: DynamicCodingKeys(stringValue: key))
                case let boolValue as Bool:
                    try container.encode(boolValue, forKey: DynamicCodingKeys(stringValue: key))
                case let dictValue as [String: String]:
                    try container.encode(dictValue, forKey: DynamicCodingKeys(stringValue: key))
                default:
                    break
                }
            }
        }

        required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
            var parameters = [String: Any]()
            
            for key in container.allKeys {
                if let stringValue = try? container.decode(String.self, forKey: key) {
                    parameters[key.stringValue] = stringValue
                } else if let boolValue = try? container.decode(Bool.self, forKey: key) {
                    parameters[key.stringValue] = boolValue
                } else if let dictValue = try? container.decode([String: String].self, forKey: key) {
                    parameters[key.stringValue] = dictValue
                }
            }
            
            self.parameters = parameters
        }

        
        struct DynamicCodingKeys: CodingKey {
            var stringValue: String
            init(stringValue: String) {
                self.stringValue = stringValue
            }
            
            var intValue: Int?
            init?(intValue: Int) {
                return nil
            }
        }
    }
    
    // MARK: - DataOptions Model
    
    class DataOptions: Codable {
        var populate: [Populate]
        var sort: Sort
        var page: Int
        var limit: Int
        
        class Populate: Codable {
            var path: String
            var select: Select
            
            class Select: Codable {
                var name: Int
                var type: Int
                
                init(name: Int, type: Int) {
                    self.name = name
                    self.type = type
                }
            }
            
            init(path: String, select: Select) {
                self.path = path
                self.select = select
            }
        }
        
        class Sort: Codable {
            var date_utc: String
            
            init(dateUTC: String) {
                self.date_utc = dateUTC
            }
        }
        
        init(populate: [Populate], sort: Sort, page: Int, limit: Int) {
            self.populate = populate
            self.sort = sort
            self.page = page
            self.limit = limit
        }
    }
    
    // MARK: - Initializer
    
    init(query: Query, options: DataOptions) {
        self.query = query
        self.options = options
    }
}

// MARK: - DataOptions Extension
extension LaunchRequestModel.DataOptions {
    
    func withPage(_ page: Int) -> LaunchRequestModel.DataOptions {
        return LaunchRequestModel.DataOptions(populate: self.populate, sort: self.sort, page: page, limit: self.limit)
    }
    
    func withLimit(_ limit: Int) -> LaunchRequestModel.DataOptions {
        return LaunchRequestModel.DataOptions(populate: self.populate, sort: self.sort, page: self.page, limit: limit)
    }
    
    func withPopulate(_ populate: [LaunchRequestModel.DataOptions.Populate]) -> LaunchRequestModel.DataOptions {
        return LaunchRequestModel.DataOptions(populate: populate, sort: self.sort, page: self.page, limit: self.limit)
    }
    
    func withSort(_ sort: LaunchRequestModel.DataOptions.Sort) -> LaunchRequestModel.DataOptions {
        return LaunchRequestModel.DataOptions(populate: self.populate, sort: sort, page: self.page, limit: self.limit)
    }
}
