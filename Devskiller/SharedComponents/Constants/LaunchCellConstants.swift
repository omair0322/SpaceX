//
//  LaunchCellConstants.swift
//  Devskiller
//
//  Created by Muhammad Omair on 09/04/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation
import UIKit

struct LaunchCellConstants {
    
    // MARK: - Font Sizes
    
    static let missionNameFontSize: CGFloat = 16
    
    static let defaultFontSize: CGFloat = 14
    
    // MARK: - Label Texts
    
    struct Labels {
        static let missionTitle = "Mission:"
        static let dateTitle = "Date/time:"
        static let rocketTitle = "Rocket:"
        static let daysTitle = "Days:"
        static let daysSinceNow = "Days Since Now:"
        static let daysFromNow = "Days From Now:"
    }
    
    // MARK: - Placeholder Texts
    
    struct Placeholders {
        static let unknownRocketType = "Unknown Type"
        static let placeholderImage = "placeholderImage"
        static let unknownMissionName = "Unknown Mission Name"
        static let unknownDate = "Unknown Date"
        static let unknownRocket = "Unknown Rocket"
        static let unknownDetails = "Details not available"
    }
    
    // MARK: - Layout Constraints
    
    struct Constraints {
        static let imageLeading: CGFloat = 16
        static let imageSize: CGFloat = 50
        static let textLeading: CGFloat = 16
        static let textTrailing: CGFloat = -16
        static let textVerticalSpacing: CGFloat = 4
        static let textBottomSpacing: CGFloat = -16
    }
}
