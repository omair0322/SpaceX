//
//  AppConstants.swift
//  Devskiller
//
//  Created by Muhammad Omair on 09/04/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation


struct AppConstants {
    
    // MARK: - Date Formats
    
    struct DateFormats {
        static let displayDateFormat = "dd MMM yyyy"
        static let dateFormat = "yyyy-MM-dd"
        static let displayTimeFormat = "HH:mm:ss"
    }
    
    // MARK: - Error Messages
    
    struct ErrorMessages {
        static let unknownError = "An unknown error occurred"
        static let invalidURL = "Invalid URL"
        static let networkError = "Network error occurred"
        static let noData = "No data received"
        static let decodingError = "Failed to decode data"
        static let fetchLaunchesFailed = "Failed to fetch launches"
        static let saveError = "Failed to save context"
        static let clearDataFailed = "Failed to clear existing data"
        static let fetchDataFailed = "Failed to fetch data"
        static let requestFailed = "Request failed"
        static let invalidData = "Invalid data received"
        static let decodingFailed = "Failed to decode data"
        static let loadError = "Failed to load persistent stores"
        static let fetchCompanyInfoFailed = "Failed to fetch company information"
        static let companyInfoDescription = "Details about the company's history, mission, and achievements."
        static let fetchDataError = "Failed to fetch data."
        static let okTitle = "OK"
        static let databaseOperationFailed = "Database operation failed"
        static let unknownMissionName = "Unknown Mission Name"
        static let unknownDate = "Unknown Date"
        static let unknownRocket = "Unknown Rocket"
    }
    
    // MARK: - Navigation
    
    struct Navigation {
        static let title = "SpaceX App"
        static let filterIconAccessibilityLabel = "Filter"
    }
    
    // MARK: - Filter Detail
    
    struct FilterDetail {
        static let okButtonTitle = "OK"
        static let cancelButtonTitle = "Cancel"
        static let launchDetailsTitle = "Launch Details"
        static let openArticleTitle = "Open Article"
        static let openWikipediaTitle = "Open Wikipedia"
        static let openVideoTitle = "Open Video"
        static let chooseOptionTitle = "Choose an option"
        static let cancelTitle = "Cancel"
        static let actionSheetTitle = "Choose an option"
    }
    
    // MARK: - Company Info
    
    struct CompanyInfo {
        static let foundedBy = "%@ was founded by %@ in %d."
        static let details = "It has now %d employees, %d launch sites, and is valued at USD %lld."
        static let companyTitle = "COMPANY"
        static let launchesTitle = "LAUNCHES"
    }

    // MARK: - Sort Order
    
    struct SortOrder {
        static let ascending = "ASC"
        static let descending = "DESC"
    }

    // MARK: - Filter
    
    struct Filter {
        static let placeholder = "Enter Launch Year"
        static let success = "Success"
        static let failed = "Failed"
        static let all = "All"
        static let ascending = "Ascending"
        static let descending = "Descending"
        static let apply = "Apply"
        static let allYears = "All Years"
        static let selectYear = "Select Year"
        static let launchStatus = "Launch Status"
        static let sortOrder = "Sort Order"
        static let filterOptions = "Filter Options"
        static let cancel = "Cancel"
    }

    // MARK: - Table View
    
    struct TableView {
        static let noDataFound =  "No data available"
    }
    
    // MARK: - Launch Detail
    
    struct LaunchDetail {
        static let date = "Date"
        static let success = "Success"
        static let openWikipedia = "Open Wikipedia"
        static let watchOnYouTube = "Watch on YouTube"
        static let visitWebsite = "Visit Website"
        static let notAvailable = "N/A"
        static let description = "Description"
        static let actions = "Action"
        static let missionTitle = "Title"
        static let completed = "Successful"
        static let failed = "Failed"
        static let title = "Launch Detail"
        static let MissionDate  = "Mission Date"
    }
    
    // MARK: - Launch List
    
    struct LaunchList {
        static let days = "days"
    }
    
    // MARK: - YouTube
    
    struct YouTube {
        static func videoURL(for videoID: String) -> String {
            return "https://www.youtube.com/watch?v=\(videoID)"
        }
    }
}
