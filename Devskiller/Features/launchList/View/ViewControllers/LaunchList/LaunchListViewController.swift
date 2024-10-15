//
//  LaunchListViewController.swift
//  Devskiller
//
//  Created by Muhammad Omair on 09/04/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import UIKit
import Combine

class LaunchListViewController: BaseViewController, LaunchListViewControllerProtocol {

    private let tableView = UITableView()
    internal let viewModel: LaunchListViewModelProtocol
    private let tableViewHandler: TableViewHandlerProtocol
    private var cancellables = Set<AnyCancellable>()

    private lazy var companyInfoHeaderView: CompanyInfoHeaderView = {
        let headerView = CompanyInfoHeaderView()
        return headerView
    }()

    private lazy var sharedCompanyInfo: AnyPublisher<CompanyResponseModel, Never> = {
        viewModel.companyInfo
            .compactMap { $0 }
            .eraseToAnyPublisher()
    }()

    private lazy var sharedLaunches: AnyPublisher<[LaunchListModel], Never> = {
        viewModel.launches
            .eraseToAnyPublisher()
    }()

    init(viewModel: LaunchListViewModelProtocol, tableViewHandler: TableViewHandlerProtocol) {
        self.viewModel = viewModel
        self.tableViewHandler = tableViewHandler
        super.init(nibName: nil, bundle: nil)
        setupUI()
        setupBindings()
        setupNavigationBar()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateTableHeaderViewHeight()
    }

    override func setupUI() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableViewHandler.configure(tableView: tableView)
        tableView.accessibilityIdentifier = UIConstants.LaunchList.launchTableIdentifier

        tableView.tableHeaderView = companyInfoHeaderView
        updateTableHeaderViewHeight()
    }

    override func setupBindings() {
        setupCompanyInfoBindings()
        setupLaunchesBindings()
    }

    private func setupCompanyInfoBindings() {
        sharedCompanyInfo
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] companyInfo in
                self?.companyInfoHeaderView.configure(with: companyInfo)
                self?.updateTableHeaderViewHeight()
            })
            .store(in: &cancellables)
    }

    private func setupLaunchesBindings() {
        sharedLaunches
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] launches in
                print("Launches received: \(launches)")
                
                self?.displayLaunches(launches)
            })
            .store(in: &cancellables)
    }

    private func updateTableHeaderViewHeight() {
        guard let header = tableView.tableHeaderView else { return }

        header.setNeedsLayout()
        header.layoutIfNeeded()

        let targetSize = CGSize(width: tableView.bounds.width, height: UIView.layoutFittingCompressedSize.height)
        let height = header.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel).height

        if header.frame.height != height {
            var frame = header.frame
            frame.size.height = height
            header.frame = frame
            tableView.tableHeaderView = header
        }
    }

    func displayLaunches(_ launches: [LaunchListModel]) {
        print("Displaying \(launches.count) launches")
        tableViewHandler.updateData(launches)
        tableView.reloadData()
    }

    func showError(_ message: String) {
        ErrorHandler.showError(message, on: self)
    }
}
