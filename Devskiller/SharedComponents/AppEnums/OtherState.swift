//
//  OtherState.swift
//  Devskiller
//
//  Created by Muhammad Omair on 09/04/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation
import UIKit

enum ImageDownloadError: Error {
    case networkError
    case invalidData
}

enum URLType: String {
    case youtubeBase = "https://www.youtube.com/watch?v="
}

enum HTTPStatusCode {
    static let successRange = 200...299
}
