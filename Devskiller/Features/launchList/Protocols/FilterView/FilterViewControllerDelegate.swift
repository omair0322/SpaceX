//
//  FilterViewControllerDelegate.swift
//  Devskiller
//
//  Created by Muhammad Omair on 09/04/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation
import UIKit

protocol FilterViewControllerDelegate: AnyObject {
    func applyFilter(year: String?, status: LaunchStatus, isAscending: Bool)
}
