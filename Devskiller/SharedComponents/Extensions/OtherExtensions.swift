//
//  OtherExtensions.swift
//  Devskiller
//
//  Created by Muhammad Omair on 09/04/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation
import UIKit
import Combine

// MARK: - Extensions for Font and Style Application

extension UISegmentedControl {

    func applyDefaultFont() {
        let font = UIFont(name: UIConstants.Fonts.mediumFont, size: UIConstants.FontSize.missionFontSize) ?? UIFont.systemFont(ofSize: UIConstants.FontSize.missionFontSize)
        let fontAttribute = [NSAttributedString.Key.font: font]
        setTitleTextAttributes(fontAttribute, for: .normal)
    }
}

extension UIApplication {

    func openAppURL(_ url: URL) {
        open(url, options: [:], completionHandler: nil)
    }
}

extension Result {
    func map<T>(_ transform: (Success) -> T) -> Result<T, Failure> {
        switch self {
        case .success(let value):
            return .success(transform(value))
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func getOrElse(_ fallback: (Failure) -> Success) -> Success {
        switch self {
        case .success(let value):
            return value
        case .failure(let error):
            return fallback(error)
        }
    }
}


extension Publisher {
    func shareReplayLatest() -> AnyPublisher<Output, Failure> {
        let subject = CurrentValueSubject<Output?, Failure>(nil)
        
        return self
            .handleEvents(receiveOutput: { output in
                subject.send(output)
            })
            .compactMap { $0 }
            .eraseToAnyPublisher()
    }
}

// Extension to convert Encodable objects to JSON Data and Dictionary
extension Encodable {

    func toJSONData() -> Data? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted // To make the JSON output readable
        return try? encoder.encode(self)
    }

    func toDictionary() -> [String: Any]? {
        guard let data = self.toJSONData() else { return nil }
        
        return try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
    }

    func toJSONString() -> String? {
        guard let data = self.toJSONData() else { return nil }
        return String(data: data, encoding: .utf8)
    }
}


extension URLRequest {
    

    func decodeBodyToJSON() -> [String: Any]? {
        guard let httpBody = self.httpBody else { return nil }
        
        do {
            // Try to decode the HTTP body as JSON
            if let jsonObject = try JSONSerialization.jsonObject(with: httpBody, options: []) as? [String: Any] {
                return jsonObject
            }
        } catch {
            print("Error decoding JSON body: \(error.localizedDescription)")
        }
        return nil
    }

    func decodeURLQueryParameters() -> [String: String]? {
        guard let url = self.url else { return nil }
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
              let queryItems = components.queryItems else {
            return nil
        }
        
        var queryDict: [String: String] = [:]
        for item in queryItems {
            queryDict[item.name] = item.value
        }
        return queryDict
    }
    
    func prettyPrintRequest() {
        var requestDetails: [String: Any] = [:]
        
        requestDetails["Method"] = self.httpMethod ?? "Unknown"
        requestDetails["URL"] = self.url?.absoluteString ?? "No URL"
        requestDetails["Headers"] = self.allHTTPHeaderFields ?? [:]
        
        if let body = self.decodeBodyToJSON() {
            requestDetails["Body"] = body
        }
        
        if let queryParameters = self.decodeURLQueryParameters() {
            requestDetails["Query Parameters"] = queryParameters
        }
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: requestDetails, options: .prettyPrinted),
           let jsonString = String(data: jsonData, encoding: .utf8) {
            print(jsonString)
        } else {
            print("Failed to serialize request details")
        }
    }
}
