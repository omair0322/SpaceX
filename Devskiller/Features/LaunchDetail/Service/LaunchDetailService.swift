//
//  LaunchDetailService.swift
//  Devskiller
//
//  Created by Muhammad Omair on 10/04/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation
import Combine

import Foundation
import Combine

class LaunchDetailService: LaunchDetailServiceProtocol {

    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }

    func fetchLaunchDetail(id: String) -> AnyPublisher<LaunchDetailModel, NetworkError> {
        guard let url = URL(string: "\(APIConstants.BaseURL.production)\(APIConstants.Endpoints.launchDetail)/\(id)") else {
            return Fail(error: NetworkError.requestFailed(AppConstants.ErrorMessages.invalidURL))
                .eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = APIConstants.HTTPMethods.get
        
        return networkService.fetch(LaunchDetailResponseModel.self, from: request)
            .map { responseModel in
                return LaunchDetailModel(from: responseModel)
            }
            .mapError { error in
                NetworkError.networkError(error.localizedDescription)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
