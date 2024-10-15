//
//  LaunchDetailViewModelProtocol.swift
//  Devskiller
//
//  Created by Muhammad Omair on 09/04/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation
import Combine

protocol LaunchDetailViewModelProtocol {

    var launchDetail: AnyPublisher<LaunchDetailModel, Never> { get }
    func fetchLaunchDetail(for launchID: String) -> AnyPublisher<Void, Error>
}
