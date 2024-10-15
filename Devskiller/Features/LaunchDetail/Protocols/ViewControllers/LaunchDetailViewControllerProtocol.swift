//
//  LaunchDetailViewControllerProtocol.swift
//  Devskiller
//
//  Created by Muhammad Omair on 09/04/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation

protocol LaunchDetailViewControllerProtocol: AnyObject {
    var viewModel: LaunchDetailViewModelProtocol { get }
    func showError(_ message: String)
}
