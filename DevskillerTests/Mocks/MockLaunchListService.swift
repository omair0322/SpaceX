//
//  MockLaunchListService.swift
//  Devskiller
//
//  Created by Muhammad Omair on 12/04/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation
import Combine
@testable import Devskiller

class MockLaunchListService: LaunchListServiceProtocol {
    
    func fetchLaunches(request: LaunchRequestModel) -> AnyPublisher<LaunchResponseModel, Error> {
        let data = TestHelper.loadMockData("MockLaunchList", bundle: Bundle(for: MockLaunchListService.self))
        
        do {
            let launchResponse = try JSONDecoder().decode(LaunchResponseModel.self, from: data)
            return Just(launchResponse)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: NetworkError.decodingFailed(error.localizedDescription))
                .eraseToAnyPublisher()
        }
    }
    
    func fetchCompanyInfo() -> AnyPublisher<CompanyResponseModel, Error> {
        let data = TestHelper.loadMockData("MockCompanyInfo", bundle: Bundle(for: MockLaunchListService.self))
        
        do {
            let companyInfo = try JSONDecoder().decode(CompanyResponseModel.self, from: data)
            return Just(companyInfo)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: NetworkError.decodingFailed(error.localizedDescription))
                .eraseToAnyPublisher()
        }
    }
}
