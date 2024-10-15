//
//  ErrorHandler.swift
//  Devskiller
//
//  Created by Muhammad Omair on 09/04/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation
import UIKit

class ErrorHandler {
    

    static func handleError(_ error: NetworkError) -> String {
        switch error {
        case .requestFailed(let message):
            return AppConstants.ErrorMessages.requestFailed.localized(defaultValue: message)
        case .invalidData:
            return AppConstants.ErrorMessages.invalidData.localized()
        case .decodingFailed:
            return AppConstants.ErrorMessages.decodingFailed.localized()
        case .unknown:
            return AppConstants.ErrorMessages.unknownError.localized()
        case .databaseOperationFailed(let message):
            return AppConstants.ErrorMessages.databaseOperationFailed.localized(defaultValue: message)
        case .networkError:
            return AppConstants.ErrorMessages.networkError.localized()
        }
    }
    

    static func showError(_ message: String, on viewController: UIViewController) {
        let alert = UIAlertController(title: UIConstants.Error.title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: UIConstants.Error.okButtonTitle, style: .default))
        viewController.present(alert, animated: true)
    }
}
