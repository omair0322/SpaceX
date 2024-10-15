//
//  UIConstants.swift
//  Devskiller
//
//  Created by Muhammad Omair on 09/04/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation
import UIKit

struct UIConstants {
    
    // MARK: - Launch List Constants
    
    struct LaunchList {
        static let launchCellIdentifier = "LaunchCellIdentifier" // Identifier for launch cells
        static let launchTableIdentifier = "LaunchTableView" // Identifier for the launch table view
    }
    
    // MARK: - Corner Radius
    
    struct CornerRadius {
        static let small = 15.0 
    }
    
    // MARK: - Error Messages
    
    struct Error {
        static let title = "Error"
        static let okButtonTitle = "OK"
    }

    // MARK: - Fonts
    
    struct Fonts {
        static let regularFont = "Karla-Regular"
        static let boldFont = "Karla-Bold"
        static let mediumFont = "Karla-Medium"
    }
    
    // MARK: - Colors
    
    struct Colors {
        static let buttonBackground = UIColor.black
    }
    
    // MARK: - Spacing
    
    struct Spacing {
        static let small: CGFloat = 8
        static let medium: CGFloat = 16
        static let large: CGFloat = 24
    }
    
    // MARK: - Font Sizes
    
    struct FontSize {
        static let imageSize: CGFloat = 50
        static let imageCornerRadius: CGFloat = 8
        static let titleFontSize: CGFloat = 14
        static let missionFontSize: CGFloat = 16
        static let detailFontSize: CGFloat = 14
        static let headerFontSize: CGFloat = 18
        static let bodyFontSize: CGFloat = 14
    }
    
    // MARK: - Margins
    
    struct Margins {
        static let topMargin: CGFloat = 16
        static let sideMargin: CGFloat = 16
        static let bottomMargin: CGFloat = 16
        static let verticalSpacing: CGFloat = 8
        static let large: CGFloat = 24
    }
    
    // MARK: - Images
    
    struct Images {
        static let filterIcon = UIImage(named: "filterIcon")
    }
}
