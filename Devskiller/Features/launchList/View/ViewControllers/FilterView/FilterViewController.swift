//
//  FilterViewController.swift
//  Devskiller
//
//  Created by Muhammad Omair on 09/04/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import UIKit

class FilterViewController: BaseViewController {
    
    weak var delegate: FilterViewControllerDelegate?
    
    // Filter properties
    private var selectedYear: String?
    private var selectedLaunchStatus: LaunchStatus = .all
    private var isAscending: Bool = true
    
    // Available years for filtering
    private let availableYears = [AppConstants.Filter.allYears.localized()] + Array(2006...2024).map { String($0) }
    
    // MARK: - UI Elements
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = AppConstants.Filter.filterOptions.localized()  
        label.textColor = .darkGray
        label.font = UIFont(name: UIConstants.Fonts.boldFont, size: UIConstants.FontSize.headerFontSize)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var yearLabel: UILabel = {
        let label = UILabel()
        label.text = AppConstants.Filter.selectYear.localized()
        label.textColor = .darkGray
        label.font = UIFont(name: UIConstants.Fonts.mediumFont, size: UIConstants.FontSize.titleFontSize)
        return label
    }()
    
    private lazy var yearPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()
    
    private lazy var launchStatusLabel: UILabel = {
        let label = UILabel()
        label.text = AppConstants.Filter.launchStatus.localized()
        label.textColor = .darkGray
        label.font = UIFont(name: UIConstants.Fonts.mediumFont, size: UIConstants.FontSize.titleFontSize)
        return label
    }()
    
    private lazy var launchStatusSegmentedControl: UISegmentedControl = {
        let items = [
            AppConstants.Filter.all.localized(),
            AppConstants.Filter.success.localized(),
            AppConstants.Filter.failed.localized()
        ]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(launchStatusChanged), for: .valueChanged)
        return segmentedControl
    }()
    
    private lazy var sortOrderLabel: UILabel = {
        let label = UILabel()
        label.text = AppConstants.Filter.sortOrder.localized()
        label.textColor = .darkGray
        label.font = UIFont(name: UIConstants.Fonts.mediumFont, size: UIConstants.FontSize.titleFontSize)
        return label
    }()
    
    private lazy var sortOrderSegmentedControl: UISegmentedControl = {
        let items = [
            AppConstants.Filter.ascending.localized(),
            AppConstants.Filter.descending.localized()
        ]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(sortOrderChanged), for: .valueChanged)
        return segmentedControl
    }()
    
    private lazy var applyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(AppConstants.Filter.apply.localized(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIConstants.Colors.buttonBackground
        button.layer.cornerRadius = UIConstants.CornerRadius.small
        button.titleLabel?.font = UIFont(name: UIConstants.Fonts.boldFont, size: UIConstants.FontSize.bodyFontSize)
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        button.addTarget(self, action: #selector(applyFilterTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(AppConstants.Filter.cancel.localized(), for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.titleLabel?.font = UIFont(name: UIConstants.Fonts.mediumFont, size: UIConstants.FontSize.bodyFontSize)
        button.addTarget(self, action: #selector(cancelFilterTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Setup UI
    override func setupUI() {
        super.setupUI()
        view.backgroundColor = .white
        
        let scrollView = UIScrollView()
        let contentView = UIView()
        
        scrollView.addSubview(contentView)
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        let stackView = UIStackView(arrangedSubviews: [
            headerLabel,
            yearLabel,
            yearPickerView,
            launchStatusLabel,
            launchStatusSegmentedControl,
            sortOrderLabel,
            sortOrderSegmentedControl,
            applyButton,
            cancelButton
        ])
        stackView.axis = .vertical
        stackView.spacing = UIConstants.Spacing.small
        stackView.alignment = .fill
        
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: UIConstants.Margins.topMargin),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: UIConstants.Margins.sideMargin),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -UIConstants.Margins.sideMargin),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -UIConstants.Margins.bottomMargin)
        ])
    }

    // MARK: - Actions
    @objc internal func launchStatusChanged() {
        switch launchStatusSegmentedControl.selectedSegmentIndex {
        case 1:
            selectedLaunchStatus = .success
        case 2:
            selectedLaunchStatus = .failed
        default:
            selectedLaunchStatus = .all
        }
    }
    
    @objc internal func sortOrderChanged() {
        isAscending = sortOrderSegmentedControl.selectedSegmentIndex == 0
    }
    
    @objc internal func applyFilterTapped() {
        delegate?.applyFilter(year: selectedYear, status: selectedLaunchStatus, isAscending: isAscending)
        dismiss(animated: true, completion: nil)
    }

    @objc internal func cancelFilterTapped() {
        dismiss(animated: true, completion: nil)
    }

    func presentAsBottomSheet(on viewController: UIViewController) {
        let transitionDelegate = BottomSheetTransitioningDelegate()
        transitioningDelegate = transitionDelegate
        modalPresentationStyle = .custom
        viewController.present(self, animated: true, completion: nil)
    }
}

// MARK: - UIPickerViewDelegate and DataSource
extension FilterViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return availableYears.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return availableYears[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedYear = availableYears[row] == AppConstants.Filter.allYears.localized() ? nil : availableYears[row]
    }
}
