//
//  LaunchDetailViewModel.swift
//  Devskiller
//
//  Created by Muhammad Omair on 10/04/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation
import Combine

class LaunchDetailViewModel: LaunchDetailViewModelProtocol {
    
    // MARK: - Properties
    
    private let service: LaunchDetailServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    private let _launchDetail = CurrentValueSubject<LaunchDetailModel?, Never>(nil)
    
    var launchDetail: AnyPublisher<LaunchDetailModel, Never> {
        _launchDetail
            .compactMap { $0 }
            .eraseToAnyPublisher()
    }
    
    private var isFetchInProgress = false

    // MARK: - Initializer
    
    init(service: LaunchDetailServiceProtocol) {
        self.service = service
    }
    
    // MARK: - Public Methods

    func fetchLaunchDetail(for launchID: String) -> AnyPublisher<Void, Error> {
        if let _ = _launchDetail.value {
          
            return Just(())
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }

        
        guard !isFetchInProgress else {
            return Empty().eraseToAnyPublisher()
        }

      
        isFetchInProgress = true

        return service.fetchLaunchDetail(id: launchID)
            .mapError { $0 as Error }
            .handleEvents(receiveOutput: { [weak self] launchDetailModel in
                self?._launchDetail.send(launchDetailModel)
            }, receiveCompletion: { [weak self] _ in
                self?.isFetchInProgress = false
            })
            .map { _ in () }
            .eraseToAnyPublisher()
    }
    
    
    func cancelSubscriptions() {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }
}
