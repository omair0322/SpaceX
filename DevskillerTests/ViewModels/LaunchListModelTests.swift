//
//  LaunchListModelTests.swift
//  Devskiller
//
//  Created by Muhammad Omair on 12/04/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import XCTest
import Quick
import Nimble
@testable import Devskiller

class LaunchListModelTests: QuickSpec {
    override func spec() {
        describe("LaunchListModel") {
            var launchModel: LaunchModel!
            var launchListModel: LaunchListModel!
            
            beforeEach {
                launchModel = LaunchModel(
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
                launchListModel = LaunchListModel(from: launchModel)
            }

            afterEach {
                launchModel = nil
                launchListModel = nil
            }

            context("when initialized with valid LaunchModel") {
                it("should properly map the data to LaunchListModel") {
                    expect(launchListModel.id).to(equal(TestConstants.launchId))
                    expect(launchListModel.name).to(equal(TestConstants.launchName))
                    expect(launchListModel.date).to(equal(TestConstants.launchDate))
                    expect(launchListModel.rocketName).to(equal(TestConstants.rocketName))
                    expect(launchListModel.rocketType).to(equal(TestConstants.rocketType))
                    expect(launchListModel.missionPatchURL).to(equal(TestConstants.missionPatchSmallURL))
                    expect(launchListModel.videoID).to(equal(TestConstants.youtubeId))
                    expect(launchListModel.wikipediaURL.absoluteString).to(equal(TestConstants.wikipediaURL))
                    expect(launchListModel.articleURL.absoluteString).to(equal(TestConstants.articleURL))
                }
            }
            
            context("when converting LaunchListModel back to LaunchModel") {
                it("should properly map the data back to LaunchModel") {
                    let convertedLaunchModel = launchListModel.toLaunchModel()
                    expect(convertedLaunchModel.id).to(equal(launchModel.id))
                    expect(convertedLaunchModel.name).to(equal(launchModel.name))
                    expect(convertedLaunchModel.dateUtc).to(equal(launchModel.dateUtc))
                    expect(convertedLaunchModel.rocket.name).to(equal(launchModel.rocket.name))
                    expect(convertedLaunchModel.links.patch.small).to(equal(launchModel.links.patch.small))
                    expect(convertedLaunchModel.links.youtubeID).to(equal(launchModel.links.youtubeID))
                    expect(convertedLaunchModel.links.article).to(equal(launchModel.links.article))
                    expect(convertedLaunchModel.links.wikipedia).to(equal(launchModel.links.wikipedia))
                }
            }
            
            context("when success value is missing") {
                it("should set success to false by default") {
                    launchModel.success = nil
                    launchListModel = LaunchListModel(from: launchModel)
                    expect(launchListModel.success).to(beFalse())
                }
            }
        }
    }
}
