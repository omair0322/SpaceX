//
//  LaunchDetailCoordinator.swift
//  Devskiller
//
//  Created by Muhammad Omair on 09/04/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation
import UIKit


class URLHandlingService: URLHandlingServiceProtocol {
    func openAppURL(_ url: URL) {
        UIApplication.shared.open(url)
    }
}


// MARK: - LaunchDetailCoordinator
class LaunchDetailCoordinator: LaunchDetailCoordinatorProtocol {
    
    private let navigationController: UINavigationController
    private let urlHandlingService: URLHandlingServiceProtocol
    
    init(navigationController: UINavigationController, urlHandlingService: URLHandlingServiceProtocol = URLHandlingService()) {
        self.navigationController = navigationController
        self.urlHandlingService = urlHandlingService
    }

    func openWikipedia(with url: URL) {
        urlHandlingService.openAppURL(url)
    }

    func openYouTube(with url: URL) {
        urlHandlingService.openAppURL(url)
    }

    func openWebsite(with url: URL) {
        urlHandlingService.openAppURL(url)
    }

    func dismiss() {
        navigationController.popViewController(animated: true)
    }
}
