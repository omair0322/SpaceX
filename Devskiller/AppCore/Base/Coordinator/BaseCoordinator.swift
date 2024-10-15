//
//  BaseCoordinator.swift
//  Devskiller
//
//  Created by Muhammad Omair on 09/04/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation
import UIKit

class BaseCoordinator {
    
    // MARK: - Properties
    
    var navigationController: UINavigationController
    
    var childCoordinators: [CoordinatorProtocol] = []
    
    // MARK: - Initializer

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Coordinator Management

    func addChildCoordinator(_ coordinator: CoordinatorProtocol) {
        childCoordinators.append(coordinator)
    }
    

    func removeChildCoordinator(_ coordinator: CoordinatorProtocol) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
    
    // MARK: - Navigation Methods
    
    func pushViewController(_ viewController: UIViewController, animated: Bool = true) {
        navigationController.pushViewController(viewController, animated: animated)
    }


    func presentViewController(_ viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        navigationController.present(viewController, animated: animated, completion: completion)
    }

    func popViewController(animated: Bool = true) {
        navigationController.popViewController(animated: animated)
    }
}
