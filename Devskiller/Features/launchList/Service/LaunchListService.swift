//
//  LaunchListService.swift
//  Devskiller
//
//  Created by Muhammad Omair on 09/04/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation
import Combine

class LaunchListService: LaunchListServiceProtocol {
    
    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }

    func fetchLaunches(request: LaunchRequestModel) -> AnyPublisher<LaunchResponseModel, any Error> {
        guard let url = URL(string: "\(APIConstants.BaseURL.production)\(APIConstants.Endpoints.allLaunches)") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = APIConstants.HTTPMethods.post
        urlRequest.addValue(APIConstants.Headers.contentTypeJSON, forHTTPHeaderField: APIConstants.Headers.contentType)
        urlRequest.httpBody = try? JSONEncoder().encode(request)
       

        
        return networkService.fetch(LaunchResponseModel.self, from: urlRequest)
            .mapError { $0 as any Error }
            .eraseToAnyPublisher()
    }


    func fetchCompanyInfo() -> AnyPublisher<CompanyResponseModel, any Error> {
        guard let url = URL(string: APIConstants.BaseURL.production + APIConstants.Endpoints.companyInfo) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = APIConstants.HTTPMethods.get

        return networkService.fetch(CompanyResponseModel.self, from: urlRequest)
            .mapError { $0 as any Error }
            .eraseToAnyPublisher()
    }
}

