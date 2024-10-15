//
//  CoordinatorProtocol.swift
//  Devskiller
//
//  Created by Muhammad Omair on 09/04/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation
import UIKit

protocol CoordinatorProtocol: AnyObject {
    
    var childCoordinators: [CoordinatorProtocol] { get set }
    
    var navigationController: UINavigationController { get set }
    
    func start()

    func addChildCoordinator(_ coordinator: CoordinatorProtocol)

    func removeChildCoordinator(_ coordinator: CoordinatorProtocol)

    func pushViewController(_ viewController: UIViewController, animated: Bool)

    func presentViewController(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?)

    func popViewController(animated: Bool)
}
