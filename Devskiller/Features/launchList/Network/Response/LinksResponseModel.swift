//
//  LinksResponseModel.swift
//  Devskiller
//
//  Created by Muhammad Omair on 09/04/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation

public struct LinksResponseModel: Codable {
    
    // MARK: - Properties
    
    public let patch: PatchResponseModel
    public let youtubeID: String?
    public let article: String?
    public let wikipedia: String?
    
    // MARK: - Initializer
    
    public init(
        patch: PatchResponseModel = PatchResponseModel(),
        youtubeID: String? = LinksDefaults.noVideoID,
        article: String? = LinksDefaults.defaultURL,
        wikipedia: String? = LinksDefaults.defaultURL
    ) {
        self.patch = patch
        self.youtubeID = youtubeID
        self.article = article
        self.wikipedia = wikipedia
    }
    
    enum CodingKeys: String, CodingKey {
        case patch
        case youtubeID = "youtube_id"
        case article
        case wikipedia
    }

    // MARK: - Nested Model
    
    public struct PatchResponseModel: Codable {
        public let small: String?
        public let large: String?

        public init(
            small: String? = LinksDefaults.placeholderPatchURL,
            large: String? = LinksDefaults.placeholderPatchURL
        ) {
            self.small = small
            self.large = large
        }
    }
}
