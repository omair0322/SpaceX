//
//  LaunchDetailModel.swift
//  Devskiller
//
//  Created by Muhammad Omair on 10/04/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation

public struct LaunchDetailModel {
    let id: String
    let name: String
    let date: String
    let success: LaunchStatus
    let rocketName: String
    let rocketType: String
    let missionPatchURL: String
    let articleURL: URL?
    let wikipediaURL: URL?
    let videoID: String
    let details: String


    init(from responseModel: LaunchDetailResponseModel) {
        self.id = responseModel.id
        self.name = responseModel.name
        self.date = responseModel.dateUTC
        self.success = responseModel.status
        
        self.rocketName = "Unknown Rocket"
        self.rocketType = "Unknown Type"

        self.missionPatchURL = responseModel.links?.patch.small ?? LinksDefaults.placeholderPatchURL
        self.articleURL = URL(string: responseModel.links?.article ?? LinksDefaults.defaultURL)
        self.wikipediaURL = URL(string: responseModel.links?.wikipedia ?? LinksDefaults.defaultURL)
        self.videoID = responseModel.links?.youtubeID ?? LinksDefaults.noVideoID
        
        self.details = responseModel.details ?? "No details available."
    }
    

}
