//
//  LaunchListServiceProtocol.swift
//  Devskiller
//
//  Created by Muhammad Omair on 09/04/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation
import Combine

protocol LaunchListServiceProtocol {
    

    func fetchLaunches(request: LaunchRequestModel) -> AnyPublisher<LaunchResponseModel, Error>
    func fetchCompanyInfo() -> AnyPublisher<CompanyResponseModel, Error>
}
