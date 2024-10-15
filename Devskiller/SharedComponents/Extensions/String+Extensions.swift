//
//  String+Extensions.swift
//  Devskiller
//
//  Created by Muhammad Omair on 09/04/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation

extension String {
    
    func toDate() -> Date? {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return dateFormatter.date(from: self)
    }

    func formattedDateAndTime() -> String? {
        
            let inputFormatter = ISO8601DateFormatter()
            inputFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
            
            // Convert the input string to a Date object
            guard let date = inputFormatter.date(from: self) else {
                return nil
            }
            
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "yyyy-MM-dd 'at' HH:mm"
            outputFormatter.timeZone = TimeZone(secondsFromGMT: 0)
            
            // Format the Date object to a string
            return outputFormatter.string(from: date)
    }
    

    func localized(defaultValue: String = "") -> String {
        let localizedString = NSLocalizedString(self, comment: "")
        return localizedString.isEmpty ? defaultValue : localizedString
    }
    
    func toURL() -> URL? {
        return URL(string: self)
    }

    func toYouTubeURL() -> URL? {
        return URL(string: URLType.youtubeBase.rawValue + self)
    }
    
}
