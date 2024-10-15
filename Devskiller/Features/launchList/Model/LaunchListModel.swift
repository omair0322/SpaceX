//
//  LaunchListModel.swift
//  Devskiller
//
//  Created by Muhammad Omair on 09/04/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//
import Foundation

struct LaunchListModel: Equatable {
    let id: String
    let name: String
    let date: String
    let success: Bool
    let rocketName: String
    let rocketType: String
    let missionPatchURL: String
    let articleURL: URL
    let wikipediaURL: URL
    let videoID: String?

    init(from responseModel: LaunchModel) {
        self.id = responseModel.id

        self.name = responseModel.name.isEmpty ? "Unknown Mission" : responseModel.name
        self.date = responseModel.dateUtc.isEmpty ? "Unknown Date" : responseModel.dateUtc

        self.success = responseModel.success ?? false
        self.rocketName = responseModel.rocket.name.isEmpty ? "Unknown Rocket" : responseModel.rocket.name
        self.rocketType = responseModel.rocket.type.isEmpty ? "Unknown Type" : responseModel.rocket.type

        self.missionPatchURL = responseModel.links.patch.small ?? "https://example.com/default-patch.png"
        self.videoID = responseModel.links.youtubeID?.isEmpty == false ? responseModel.links.youtubeID : nil

        self.articleURL = URL(string: responseModel.links.article ?? "https://example.com/default-article")!
        self.wikipediaURL = URL(string: responseModel.links.wikipedia ?? "https://example.com/default-wiki")!
    }
}

extension LaunchListModel {
    func toLaunchModel() -> LaunchModel {
        return LaunchModel(
            id: self.id,
            name: self.name,
            dateUtc: self.date,
            success: self.success,
            rocket: RocketResponseModel(
                name: self.rocketName,
                type: self.rocketType,
                id: self.id
            ),
            links: LinksResponseModel(
                patch: LinksResponseModel.PatchResponseModel(
                    small: self.missionPatchURL,
                    large: ""
                ),
                youtubeID: self.videoID,
                article: self.articleURL.absoluteString,
                wikipedia: self.wikipediaURL.absoluteString
            )
        )
    }
}
