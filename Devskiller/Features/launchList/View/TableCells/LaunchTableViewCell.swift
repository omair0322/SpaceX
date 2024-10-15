//
//  LaunchTableViewCell.swift
//  Devskiller
//
//  Created by Muhammad Omair on 09/04/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation
import UIKit

class LaunchTableViewCell: UITableViewCell {

    // MARK: - UI Elements
    private let missionPatchImageView = UIImageView()
    private let missionNameLabel = UILabel()
    private let dateLabel = UILabel()
    private let rocketLabel = UILabel()
    private let daysLabel = UILabel()
    private let successIconImageView = UIImageView()
    
    private let missionTitleLabel = UILabel()
    private let dateTimeTitleLabel = UILabel()
    private let rocketTitleLabel = UILabel()
    private let daysTitleLabel = UILabel()
    
    private let activityIndicator = UIActivityIndicatorView(style: .medium)

    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup UI
    private func setupUI() {
        // Configure Image View
        missionPatchImageView.contentMode = .scaleAspectFit
        missionPatchImageView.clipsToBounds = true
        missionPatchImageView.layer.cornerRadius = UIConstants.FontSize.imageCornerRadius
        missionPatchImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Configure Activity Indicator
        activityIndicator.hidesWhenStopped = true
        missionPatchImageView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        // Configure Title Labels
        configureTitleLabel(missionTitleLabel, withText: LaunchCellConstants.Labels.missionTitle)
        configureTitleLabel(dateTimeTitleLabel, withText: LaunchCellConstants.Labels.dateTitle)
        configureTitleLabel(rocketTitleLabel, withText: LaunchCellConstants.Labels.rocketTitle)
        configureTitleLabel(daysTitleLabel, withText: LaunchCellConstants.Labels.daysTitle)
        
        // Configure Detail Labels
        configureDetailLabel(missionNameLabel)
        configureDetailLabel(dateLabel)
        configureDetailLabel(rocketLabel)
        configureDetailLabel(daysLabel)
        
        // Configure Stack Views
        let missionStackView = createStackView(withArrangedSubviews: [missionTitleLabel, missionNameLabel])
        let dateStackView = createStackView(withArrangedSubviews: [dateTimeTitleLabel, dateLabel])
        let rocketStackView = createStackView(withArrangedSubviews: [rocketTitleLabel, rocketLabel])
        let daysStackView = createStackView(withArrangedSubviews: [daysTitleLabel, daysLabel])

        let infoStackView = UIStackView(arrangedSubviews: [missionStackView, dateStackView, rocketStackView, daysStackView])
        infoStackView.axis = .vertical
        infoStackView.spacing = UIConstants.Spacing.small
        infoStackView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(missionPatchImageView)
        contentView.addSubview(successIconImageView)
        contentView.addSubview(infoStackView)
        
        successIconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add Constraints
        NSLayoutConstraint.activate([
            missionPatchImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            missionPatchImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            missionPatchImageView.widthAnchor.constraint(equalToConstant: UIConstants.FontSize.imageSize),
            missionPatchImageView.heightAnchor.constraint(equalToConstant: UIConstants.FontSize.imageSize),

            activityIndicator.centerXAnchor.constraint(equalTo: missionPatchImageView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: missionPatchImageView.centerYAnchor),

            successIconImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            successIconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            successIconImageView.widthAnchor.constraint(equalToConstant: 20),
            successIconImageView.heightAnchor.constraint(equalToConstant: 20),

            infoStackView.leadingAnchor.constraint(equalTo: missionPatchImageView.trailingAnchor, constant: 16),
            infoStackView.trailingAnchor.constraint(equalTo: successIconImageView.leadingAnchor, constant: -16),
            infoStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            infoStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }

    private func configureTitleLabel(_ label: UILabel, withText text: String) {
        label.text = text
        label.font = UIFont(name: UIConstants.Fonts.regularFont, size: UIConstants.FontSize.titleFontSize)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
    }

    private func configureDetailLabel(_ label: UILabel) {
        label.font = UIFont(name: UIConstants.Fonts.regularFont, size: UIConstants.FontSize.detailFontSize)
        label.textColor = .gray
        label.numberOfLines = 0
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
    }

    private func createStackView(withArrangedSubviews subviews: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: subviews)
        stackView.axis = .horizontal
        stackView.spacing = UIConstants.Spacing.small
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }

    func configure(with model: LaunchListModel) {
        let currentDate = Date()
        print(model)
        
        if let launchDate = model.date.toDate() {
            let daysBetween = Calendar.current.dateComponents([.day], from: currentDate, to: launchDate).day ?? 0
            
            missionNameLabel.text = model.name
            dateLabel.text = model.date.formattedDateAndTime()

            rocketLabel.text = "\(model.rocketName) / \(model.rocketType)"

            daysTitleLabel.text = daysBetween > 0 ? LaunchCellConstants.Labels.daysFromNow : LaunchCellConstants.Labels.daysSinceNow
            daysLabel.text = "\(daysBetween) " + AppConstants.LaunchList.days

            successIconImageView.image = model.success ? UIImage(named: ImageConstants.Custom.successIcon) : UIImage(named: ImageConstants.Custom.failureIcon)

            let imageURL = URL(string: model.missionPatchURL)!
            activityIndicator.startAnimating()
            missionPatchImageView.setImage(from: imageURL) { [weak self] _ in
                self?.activityIndicator.stopAnimating()
            }
        } else {
             activityIndicator.stopAnimating()
            missionPatchImageView.image = UIImage(named: LaunchCellConstants.Placeholders.placeholderImage)
        }
    }

    
    // MARK: - Cell Selection Animation
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }


}
