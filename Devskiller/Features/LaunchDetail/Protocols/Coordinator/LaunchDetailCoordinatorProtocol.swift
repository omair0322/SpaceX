//
//  LaunchDetailCoordinatorProtocol.swift
//  Devskiller
//
//  Created by Muhammad Omair on 09/04/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation

// MARK: - LaunchDetailCoordinatorProtocol
protocol LaunchDetailCoordinatorProtocol {
    func openWikipedia(with url: URL)
    func openYouTube(with url: URL)
    func openWebsite(with url: URL)
    func dismiss()
}
