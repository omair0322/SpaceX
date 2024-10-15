//
//  TestHelpers.swift
//  Devskiller
//
//  Created by Muhammad Omair on 12/04/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation
class TestHelper {
    static func loadMockData(_ fileName: String, bundle: Bundle) -> Data {
        guard let url = bundle.url(forResource: fileName, withExtension: "json") else {
            fatalError("Could not find \(fileName).json")
        }
        do {
            return try Data(contentsOf: url)
        } catch {
            fatalError("Could not load data from \(fileName).json: \(error)")
        }
    }
}
