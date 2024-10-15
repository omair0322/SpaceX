//
//  LaunchListServiceTests.swift
//  Devskiller
//
//  Created by Muhammad Omair on 12/04/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.

import Foundation
import Quick
import Nimble
import Combine
@testable import Devskiller

class LaunchListServiceTests: QuickSpec {

    override func spec() {
        var service: LaunchListService!
        var mockNetworkService: MockNetworkService!
        var cancellables: Set<AnyCancellable>!

        beforeEach {
            cancellables = Set<AnyCancellable>()
            mockNetworkService = MockNetworkService()
            service = LaunchListService(networkService: mockNetworkService)
        }

        afterEach {
            cancellables = nil
            mockNetworkService = nil
            service = nil
        }

        describe("fetchLaunches") {
            
            context("when the request is successful") {
                it("should return the correct number of launches") {

                    // Load mock data from the JSON file
                    let mockData = TestHelper.loadMockData("MockLaunchList", bundle: Bundle(for: LaunchListServiceTests.self))

                    mockNetworkService.mockResponse = .success(mockData)

                    let queryParameters: [String: Any] = ["from": "2022-01-01", "to": "2023-01-01", "success": true]
                    let query = LaunchRequestModel.Query(parameters: queryParameters)
                    let sort = LaunchRequestModel.DataOptions.Sort(dateUTC: "asc")
                    let options = LaunchRequestModel.DataOptions(populate: [], sort: sort, page: 1, limit: 10)
                    let requestModel = LaunchRequestModel(query: query, options: options)

                    waitUntil(timeout: 2) { done in
                        service.fetchLaunches(request: requestModel)
                            .sink(receiveCompletion: { completion in
                                if case .failure(let error) = completion {
                                    fail("Expected success, but got error: \(error)")
                                }
                            }, receiveValue: { launchResponse in
                                expect(launchResponse.docs.count).to(equal(1))  // Adjust the count as per your mock data
                                done()
                            })
                            .store(in: &cancellables)
                    }
                }
            }
        }
    }
}
