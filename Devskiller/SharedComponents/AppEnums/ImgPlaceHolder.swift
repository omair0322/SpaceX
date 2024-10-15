//
//  imgPlaceHolder.swift
//  Devskiller
//
//  Created by Muhammad Omair on 09/04/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation
import UIKit
enum PlaceholderImage {
    case `default`
    case custom(UIImage)
    
    var image: UIImage {
        switch self {
        case .default:
            return UIImage(named: LaunchCellConstants.Placeholders.placeholderImage) ?? UIImage()
        case .custom(let image):
            return image
        }
    }
}
