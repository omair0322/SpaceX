//
//  LaunchListCoordinatorTests.swift
//  Devskiller
//
//  Created by Muhammad Omair on 12/04/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//
import Foundation
import Quick
import Nimble
@testable import Devskiller

class LaunchListCoordinatorTests: QuickSpec {

    override func spec() {
        var coordinator: LaunchListCoordinator!
        var mockNavigationController: MockNavigationController!
        var mockLaunchListService: MockLaunchListService!
        var mockLaunchDetailService: MockLaunchDetailService!

        beforeEach {
            mockNavigationController = MockNavigationController()
            mockLaunchListService = MockLaunchListService()
            mockLaunchDetailService = MockLaunchDetailService()
            coordinator = LaunchListCoordinator(navigationController: mockNavigationController, service: mockLaunchListService, detailService: mockLaunchDetailService)
        }

        afterEach {
            coordinator = nil
            mockNavigationController = nil
            mockLaunchListService = nil
            mockLaunchDetailService = nil
        }

        describe("showLaunchDetail") {
            it("attempts to navigate to LaunchDetailViewController when a launch is selected") {
                let launchModel = LaunchModel(
                    id: TestConstants.launchId,
                    name: TestConstants.launchName,
                    dateUtc: TestConstants.launchDate,
                    success: true,
                    rocket: RocketResponseModel(name: TestConstants.rocketName, type: TestConstants.rocketType, id: TestConstants.rocketId),
                    links: LinksResponseModel(
                        patch: LinksResponseModel.PatchResponseModel(small: TestConstants.missionPatchSmallURL, large: nil),
                        youtubeID: TestConstants.youtubeId,
                        article: TestConstants.articleURL,
                        wikipedia: TestConstants.wikipediaURL
                    )
                )

                let mockLaunch = LaunchListModel(from: launchModel)

                coordinator.showLaunchDetail(for: mockLaunch)

                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    expect(mockNavigationController.pushedViewController).to(beAKindOf(LaunchDetailViewController.self))
                }
            }
        }
    }
}
