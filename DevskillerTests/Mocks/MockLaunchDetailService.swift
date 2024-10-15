//
//  MockLaunchDetailService.swift
//  Devskiller
//
//  Created by Muhammad Omair on 12/04/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//
import Foundation
import Combine
@testable import Devskiller

class MockLaunchDetailService: LaunchDetailServiceProtocol {
    
    func fetchLaunchDetail(id: String) -> AnyPublisher<LaunchDetailModel, NetworkError> {
        let data = TestHelper.loadMockData("MockLaunchDetail", bundle: Bundle(for: MockLaunchDetailService.self))
        
        do {
            let launchDetailResponse = try JSONDecoder().decode(LaunchDetailResponseModel.self, from: data)
            
            let launchDetail = LaunchDetailModel(from: launchDetailResponse)
            return Just(launchDetail)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: NetworkError.decodingFailed(error.localizedDescription))
                .eraseToAnyPublisher()
        }
    }
}
