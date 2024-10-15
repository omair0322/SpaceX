//
//  LaunchListViewModelProtocol.swift
//  Devskiller
//
//  Created by Muhammad Omair on 09/04/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Combine

protocol LaunchListViewModelProtocol: AnyObject {
    var launches: AnyPublisher<[LaunchListModel], Never> { get }
    var companyInfo: AnyPublisher<CompanyResponseModel?, Never> { get }
    var isFetching: Bool { get }  

    func fetchCompanyInfo()
    func fetchLaunches(request: LaunchRequestModel)
    func didSelectLaunch(_ launch: LaunchListModel)
    func applyFilter(year: String?, status: LaunchStatus, isAscending: Bool)

    func fetchMoreLaunches() -> AnyPublisher<Void, Error>
}
