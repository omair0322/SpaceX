//
//  LaunchListTableViewHandler.swift
//  Devskiller
//
//  Created by Muhammad Omair on 09/04/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation
import UIKit
import Combine

class LaunchListTableViewHandler: NSObject, TableViewHandlerProtocol {
    
    // MARK: - Properties
    
    private var launches: [LaunchListModel] = []
    private let didSelectLaunch: (LaunchListModel) -> Void
    private let headerView: UIView
    private let viewModel: LaunchListViewModelProtocol
    private var cancellables = Set<AnyCancellable>()
    private weak var tableView: UITableView?
    
    // A label to display when there's no data
    private let noDataLabel: UILabel = {
        let label = UILabel()
        label.text = AppConstants.TableView.noDataFound
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .gray
        label.isHidden = true
        return label
    }()
    
    init(didSelectLaunch: @escaping (LaunchListModel) -> Void, headerView: UIView, viewModel: LaunchListViewModelProtocol) {
        self.didSelectLaunch = didSelectLaunch
        self.headerView = headerView
        self.viewModel = viewModel
        super.init()
        bindLaunches()
    }
    
    // MARK: - Configuration
    
    func configure(tableView: UITableView) {
        self.tableView = tableView
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(LaunchTableViewCell.self, forCellReuseIdentifier: UIConstants.LaunchList.launchCellIdentifier)
        tableView.tableHeaderView = headerView
        
        // Add no data label to the table view background
        tableView.backgroundView = noDataLabel
    }
    
    // MARK: - Data Binding
    
    private func bindLaunches() {
        viewModel.launches
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] launches in
                self?.updateData(launches)
            })
            .store(in: &cancellables)
    }

    // MARK: - Data Handling
    
    internal func updateData(_ launches: [LaunchListModel]) {
        guard self.launches != launches else { return }
        self.launches = launches
        tableView?.reloadData()
        
        // Show the "No data" label if the launches array is empty
        noDataLabel.isHidden = !launches.isEmpty
    }

    // MARK: - Infinite Scrolling
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let tableView = tableView else { return }

        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let scrollViewHeight = scrollView.frame.size.height

        if offsetY > contentHeight - scrollViewHeight {
            let lastVisibleRowIndex = tableView.indexPathsForVisibleRows?.last?.row ?? 0
            let totalRows = tableView.numberOfRows(inSection: 0)

            if lastVisibleRowIndex == totalRows - 1 && !viewModel.isFetching {
                fetchMoreLaunches()
            }
        }
    }

    
    private func fetchMoreLaunches() {
        viewModel.fetchMoreLaunches()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Failed to fetch more launches: \(error.localizedDescription)")
                case .finished:
                    print("Successfully fetched more launches.")
                }
            }, receiveValue: { })
            .store(in: &cancellables)
    }

    // MARK: - UITableViewDataSource and UITableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return launches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UIConstants.LaunchList.launchCellIdentifier, for: indexPath) as? LaunchTableViewCell else {
            return UITableViewCell()
        }
        
        let launch = launches[indexPath.row]
        
        cell.configure(with: launch)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedLaunch = launches[indexPath.row]
        didSelectLaunch(selectedLaunch)
    }
}
