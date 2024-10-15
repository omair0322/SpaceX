//
//  LaunchListViewController+Navigation.swift
//  Devskiller
//
//  Created by Muhammad Omair on 09/04/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Navigation Bar Setup
extension LaunchListViewController: FilterViewControllerDelegate {

    func setupNavigationBar() {
        
        navigationItem.title = AppConstants.Navigation.title.localized()
        
        let filterButton = UIBarButtonItem(
            image: UIConstants.Images.filterIcon,
            style: .plain,
            target: self,
            action: #selector(filterButtonTapped)
        )
        filterButton.accessibilityLabel = AppConstants.Navigation.filterIconAccessibilityLabel.localized()
        navigationItem.rightBarButtonItem = filterButton
    }
    
    @objc private func filterButtonTapped() {
        let filterVC = FilterViewController()
        
        let bottomSheetTransitioningDelegate = BottomSheetTransitioningDelegate()
        filterVC.transitioningDelegate = bottomSheetTransitioningDelegate
        filterVC.modalPresentationStyle = .custom
        filterVC.delegate = self
        
        present(filterVC, animated: true, completion: nil)
    }
    
    func applyFilter(year: String?, status: LaunchStatus, isAscending: Bool) {
        let mappedStatus: LaunchStatus = status
        
        // Apply filter via view model
        viewModel.applyFilter(year: year, status: mappedStatus, isAscending: isAscending)
    }
}
