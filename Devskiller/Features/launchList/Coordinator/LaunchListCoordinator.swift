//
//  LaunchListCoordinator.swift
//  Devskiller
//
//  Created by Muhammad Omair on 09/04/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation
import UIKit
import Combine

class LaunchListCoordinator: LaunchListCoordinatorProtocol {

    let navigationController: UINavigationController
    private var cancellables = Set<AnyCancellable>()
    
    private lazy var viewModel: LaunchListViewModelProtocol = {
        LaunchListCoordinator.createViewModel(service: service, coordinator: self)
    }()
    
    private let service: LaunchListServiceProtocol
    private let detailService: LaunchDetailServiceProtocol

    init(navigationController: UINavigationController, service: LaunchListServiceProtocol, detailService: LaunchDetailServiceProtocol) {
        self.navigationController = navigationController
        self.service = service
        self.detailService = detailService
    }

    func start() {
        let headerView = createHeaderView(viewModel: viewModel)
        let tableViewHandler = createTableViewHandler(viewModel: viewModel, headerView: headerView)
        let launchListViewController = createLaunchListViewController(viewModel: viewModel, tableViewHandler: tableViewHandler)
        navigationController.viewControllers = [launchListViewController]
    }

    private static func createViewModel(service: LaunchListServiceProtocol, coordinator: LaunchListCoordinatorProtocol) -> LaunchListViewModelProtocol {
        return LaunchListViewModel(service: service, coordinator: coordinator)
    }

    private func createHeaderView(viewModel: LaunchListViewModelProtocol) -> CompanyInfoHeaderView {
        let headerView = CompanyInfoHeaderView()
        viewModel.companyInfo
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { companyInfo in
                headerView.configure(with: companyInfo) // Configures the headerView
            })
            .store(in: &cancellables)

        return headerView
    }

    private func createTableViewHandler(viewModel: LaunchListViewModelProtocol, headerView: UIView) -> LaunchListTableViewHandler {
        return LaunchListTableViewHandler(
            didSelectLaunch: { [weak self] selectedLaunch in
                self?.showLaunchDetail(for: selectedLaunch)
            },
            headerView: headerView,
            viewModel: viewModel
        )
    }

    private func createLaunchListViewController(viewModel: LaunchListViewModelProtocol, tableViewHandler: LaunchListTableViewHandler) -> LaunchListViewController {
        return LaunchListViewController(
            viewModel: viewModel,
            tableViewHandler: tableViewHandler
        )
    }

    func showLaunchDetail(for launch: LaunchListModel) {
        let detailViewModel = LaunchDetailViewModel(service: detailService)
        
        detailViewModel.fetchLaunchDetail(for: launch.id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.handleError(completion: completion)
            }, receiveValue: { [weak self] _ in
                guard let self = self else { return }
                let detailViewController = self.createLaunchDetailViewController(viewModel: detailViewModel)
                self.navigationController.pushViewController(detailViewController, animated: true)
            })
            .store(in: &cancellables)
    }


    private func createLaunchDetailViewController(viewModel: LaunchDetailViewModel) -> LaunchDetailViewController {
        return LaunchDetailViewController(viewModel: viewModel)
    }

    private func handleError(completion: Subscribers.Completion<Error>) {
        if case .failure(let error) = completion {
            print("Error: \(error.localizedDescription)")
            
        }
    }
}
