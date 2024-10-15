//
//  LaunchListViewModel.swift
//  Devskiller
//
//  Created by Muhammad Omair on 09/04/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation
import Combine

class LaunchListViewModel: LaunchListViewModelProtocol {

    // MARK: - Properties

    private(set) var isFetching = false
    private let launchesPublisher = CurrentValueSubject<[LaunchListModel], Never>([])
    private let companyInfoPublisher = CurrentValueSubject<CompanyResponseModel?, Never>(nil)

    private let service: LaunchListServiceProtocol
    private let coordinator: LaunchListCoordinatorProtocol
    private var cancellables = Set<AnyCancellable>()

    private var currentPage = 1
    private var hasFetchedCompanyInfo = false
    private var filterCriteria = FilterCriteria()

    // MARK: - Initializer

    init(service: LaunchListServiceProtocol, coordinator: LaunchListCoordinatorProtocol) {
        self.service = service
        self.coordinator = coordinator
        fetchCompanyInfo()
    }

    // MARK: - Public Methods

    var launches: AnyPublisher<[LaunchListModel], Never> {
        launchesPublisher.eraseToAnyPublisher()
    }

    var companyInfo: AnyPublisher<CompanyResponseModel?, Never> {
        companyInfoPublisher.eraseToAnyPublisher()
    }

    func fetchCompanyInfo() {
        guard !hasFetchedCompanyInfo else { return }

        hasFetchedCompanyInfo = true

        service.fetchCompanyInfo()
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.handleError(error, message: AppConstants.ErrorMessages.fetchCompanyInfoFailed)
                }
            }, receiveValue: { [weak self] companyInfo in
                self?.companyInfoPublisher.send(companyInfo)
                self?.fetchInitialLaunches()
            })
            .store(in: &cancellables)
    }

   
    func fetchLaunches(request: LaunchRequestModel) {
        guard !isFetching else { return }
        isFetching = true
    
        
        
        service.fetchLaunches(request: request)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .failure(let error):
                    self.handleError(error, message: AppConstants.ErrorMessages.fetchLaunchesFailed)
                case .finished:
                    print("Fetch completed successfully")
                }
                self.isFetching = false
            }, receiveValue: { [weak self] responseModel in
                guard let self = self else { return }
                
                
                let newLaunches = responseModel.docs.map { LaunchListModel(from: $0) }
                self.handleFetchSuccess(newLaunches)
                if !responseModel.docs.isEmpty {
                    self.currentPage += 1
                }
            })
            .store(in: &cancellables)
    }

    func applyFilter(year: String?, status: LaunchStatus, isAscending: Bool) {
        filterCriteria = FilterCriteria(year: year, status: status, isAscending: isAscending)
        currentPage = 1
        launchesPublisher.send([])
        fetchLaunches(request: createLaunchRequestModel(page: currentPage, filterCriteria: filterCriteria))
    }

    func fetchMoreLaunches() -> AnyPublisher<Void, Error> {
        return Future<Void, Error> { [weak self] promise in
            guard let self = self else {
                return promise(.failure(NetworkError.unknown("Failed due to self being nil")))
            }

            let request = self.createLaunchRequestModel(page: self.currentPage, filterCriteria: self.filterCriteria)
            self.fetchLaunches(request: request)

            promise(.success(()))
        }
        .eraseToAnyPublisher()
    }

    // Handle launch selection
    func didSelectLaunch(_ launch: LaunchListModel) {
        coordinator.showLaunchDetail(for: launch)
    }

    // MARK: - Private Methods

    private func fetchInitialLaunches() {
        let request = createLaunchRequestModel(page: currentPage, filterCriteria: filterCriteria)
        
      
        if let jsonDict = request.toJSONString() {
            print(jsonDict)
            
        }
        
        fetchLaunches(request: request)
    }

    private func createLaunchRequestModel(page: Int, filterCriteria: FilterCriteria) -> LaunchRequestModel {
        let query = filterCriteria.createQuery()
        let options = createOptions(page: page, isAscending: filterCriteria.isAscending)
        
        print("Creating LaunchRequestModel:")
        print("Query: \(query)")
        print("Options: \(options)")

        return LaunchRequestModel(query: query, options: options)
    }

    private func createOptions(page: Int, isAscending: Bool) -> LaunchRequestModel.DataOptions {
        return LaunchRequestModel.DataOptions(
            populate: [
                LaunchRequestModel.DataOptions.Populate(
                    path: APIConstants.QueryParameters.rocket,
                    select: LaunchRequestModel.DataOptions.Populate.Select(name: 1, type: 1)
                )
            ],
            sort: LaunchRequestModel.DataOptions.Sort(dateUTC: isAscending ? APIConstants.QueryParameters.asc : APIConstants.QueryParameters.desc),
            page: page,
            limit: APIConstants.QueryParameters.limit
        )
    }

    private func handleFetchSuccess(_ newLaunches: [LaunchListModel]) {
        
        let uniqueNewLaunches = newLaunches.filter { newLaunch in
            !launchesPublisher.value.contains(where: { $0.id == newLaunch.id })
        }
        launchesPublisher.send(launchesPublisher.value + uniqueNewLaunches)
    }

    private func handleError(_ error: Error, message: String) {
        print(APIError.requestFailed(message.localized() + ": \(error.localizedDescription)"))
    }
}
