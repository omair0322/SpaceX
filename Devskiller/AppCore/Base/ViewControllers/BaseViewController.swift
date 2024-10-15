//
//  BaseViewController.swift
//  Devskiller
//
//  Created by Muhammad Omair on 09/04/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation
import UIKit


class BaseViewController: UIViewController, BaseViewControllerProtocol {

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
    }

    // MARK: - Setup Methods
    
    func setupUI() {
        // Default implementation (can be overridden)
    }
    
    func setupBindings() {
        // Default implementation (can be overridden)
    }
}
