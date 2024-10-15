//
//  NetworkServiceProtocol.swift
//  Devskiller
//
//  Created by Muhammad Omair on 09/04/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation
import Combine

protocol NetworkServiceProtocol {
    func fetch<T: Decodable>(_ type: T.Type, from request: URLRequest) -> AnyPublisher<T, NetworkError>
}
