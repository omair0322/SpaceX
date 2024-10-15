//
//  LaunchDetailServiceProtocol.swift
//  Devskiller
//
//  Created by Muhammad Omair on 09/04/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation
import Combine

protocol LaunchDetailServiceProtocol {
   
    func fetchLaunchDetail(id: String) -> AnyPublisher<LaunchDetailModel, NetworkError>
}
