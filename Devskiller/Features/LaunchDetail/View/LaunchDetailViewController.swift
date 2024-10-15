//
//  LaunchDetailViewController.swift
//  Devskiller
//
//  Created by Muhammad Omair on 10/04/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//
import UIKit
import Combine

class LaunchDetailViewController: BaseViewController, LaunchDetailViewControllerProtocol {
    
    let viewModel: LaunchDetailViewModelProtocol
    private var cancellables = Set<AnyCancellable>()
    
    private var launchDetail: LaunchDetailModel?
    
    // UI Elements
    private let missionImageView = UIImageView()
    private let titleLabel = UILabel()

    private let missionSectionLabel = UILabel()
    private let dateLabel = UILabel()
    private let successLabel = UILabel()

    private let descriptionLabel = UILabel()

    private let wikipediaButton = UIButton(type: .system)
    private let youtubeButton = UIButton(type: .system)
    private let websiteButton = UIButton(type: .system)
    
    // MARK: - Initializer
    init(viewModel: LaunchDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupUI()
        setupBindings()
        setupNavigationBar()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI Setup
    override func setupUI() {
        view.backgroundColor = .systemBackground

        // Mission Image View
        missionImageView.contentMode = .scaleAspectFit
        missionImageView.clipsToBounds = true
        missionImageView.layer.cornerRadius = 10
        
        // Title Section
        titleLabel.font = UIFont(name: UIConstants.Fonts.boldFont, size: UIConstants.FontSize.headerFontSize)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0

        // Mission Section
        missionSectionLabel.text = AppConstants.LaunchDetail.MissionDate.localized()
        missionSectionLabel.font = UIFont(name: UIConstants.Fonts.regularFont, size: UIConstants.FontSize.bodyFontSize)
        
        dateLabel.font = UIFont(name: UIConstants.Fonts.regularFont, size: UIConstants.FontSize.bodyFontSize)
        successLabel.font = UIFont(name: UIConstants.Fonts.regularFont, size: UIConstants.FontSize.bodyFontSize)

        // Description Section
        descriptionLabel.font = UIFont(name: UIConstants.Fonts.regularFont, size: UIConstants.FontSize.bodyFontSize)
        descriptionLabel.numberOfLines = 0

        // Buttons
        wikipediaButton.setTitle(AppConstants.LaunchDetail.openWikipedia.localized(), for: .normal)
        youtubeButton.setTitle(AppConstants.LaunchDetail.watchOnYouTube.localized(), for: .normal)
        websiteButton.setTitle(AppConstants.LaunchDetail.visitWebsite.localized(), for: .normal)

        // Configure button appearances
        let buttons = [wikipediaButton, youtubeButton, websiteButton]
        buttons.forEach {
            $0.titleLabel?.font = UIFont(name: UIConstants.Fonts.mediumFont, size: UIConstants.FontSize.bodyFontSize) 
            $0.setTitleColor(.systemBlue, for: .normal)
            $0.setTitleColor(.gray, for: .disabled)
        }

        // Add all elements to the view
        view.addSubview(missionImageView)
        view.addSubview(titleLabel)
        view.addSubview(missionSectionLabel)
        view.addSubview(dateLabel)
        view.addSubview(successLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(wikipediaButton)
        view.addSubview(youtubeButton)
        view.addSubview(websiteButton)

        setupConstraints()
    }

    // MARK: - Constraints
    private func setupConstraints() {
        missionImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        missionSectionLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        successLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        wikipediaButton.translatesAutoresizingMaskIntoConstraints = false
        youtubeButton.translatesAutoresizingMaskIntoConstraints = false
        websiteButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // Mission Image Section
            missionImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            missionImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            missionImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            missionImageView.heightAnchor.constraint(equalToConstant: 200),

            // Title Section
            titleLabel.topAnchor.constraint(equalTo: missionImageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            // Mission Section
            missionSectionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            missionSectionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            dateLabel.topAnchor.constraint(equalTo: missionSectionLabel.bottomAnchor, constant: 5),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            successLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 5),
            successLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            // Description Section
            descriptionLabel.topAnchor.constraint(equalTo: successLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            // Buttons Section
            wikipediaButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            wikipediaButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            youtubeButton.topAnchor.constraint(equalTo: wikipediaButton.bottomAnchor, constant: 20),
            youtubeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            websiteButton.topAnchor.constraint(equalTo: youtubeButton.bottomAnchor, constant: 20),
            websiteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }

    // MARK: - Binding Setup
    override func setupBindings() {
        viewModel.launchDetail
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.showError(error.localizedDescription)
                }
            }, receiveValue: { [weak self] launchDetail in
                self?.launchDetail = launchDetail
                self?.updateUI(with: launchDetail)
            })
            .store(in: &cancellables)
    }

    private func updateUI(with launchDetail: LaunchDetailModel) {
        titleLabel.text = launchDetail.name
        dateLabel.text = launchDetail.date
        successLabel.text = launchDetail.success.displayName
        descriptionLabel.text = launchDetail.details
        setupButtons(with: launchDetail)

        // Set the mission image using the URL
        if let missionImageURL = URL(string: launchDetail.missionPatchURL) {
            missionImageView.setImage(from: missionImageURL)
        }
    }

    private func setupButtons(with launchDetail: LaunchDetailModel) {
        configureButtonAction(wikipediaButton, url: launchDetail.wikipediaURL)
        configureButtonAction(youtubeButton, url: URL(string: AppConstants.YouTube.videoURL(for: launchDetail.videoID)))
        configureButtonAction(websiteButton, url: launchDetail.articleURL)
    }

    private func configureButtonAction(_ button: UIButton, url: URL?) {
        button.isEnabled = url != nil
        button.alpha = url != nil ? 1.0 : 0.5
        button.removeTarget(nil, action: nil, for: .allEvents)

        if url != nil {
            button.addTarget(self, action: #selector(handleButtonTap(_:)), for: .touchUpInside)
            button.tag = 1
        } else {
            button.tag = 0
        }
    }


    @objc private func handleButtonTap(_ sender: UIButton) {
        guard sender.tag == 1 else { return }

        let buttonTitle = sender.title(for: .normal)
        guard let urlString = getURLString(for: buttonTitle),
              let url = URL(string: urlString) else { return }

        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }

    private func getURLString(for buttonTitle: String?) -> String? {
        switch buttonTitle {
        case AppConstants.LaunchDetail.openWikipedia.localized():
            return launchDetail?.wikipediaURL?.absoluteString
        case AppConstants.LaunchDetail.watchOnYouTube.localized():
            if let videoID = launchDetail?.videoID {
                return AppConstants.YouTube.videoURL(for: videoID)
            }
            return nil
        case AppConstants.LaunchDetail.visitWebsite.localized():
            return launchDetail?.articleURL?.absoluteString
        default:
            return nil
        }
    }

    // MARK: - Error Handling
    
    func showError(_ message: String) {
        ErrorHandler.showError(message, on: self)
    }

    // MARK: - Navigation Setup
    private func setupNavigationBar() {
        navigationItem.title = AppConstants.LaunchDetail.title.localized()
    }
}
