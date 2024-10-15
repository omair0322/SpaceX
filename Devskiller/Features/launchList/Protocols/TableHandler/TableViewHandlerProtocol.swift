//
//  TableViewHandlerProtocol.swift
//  Devskiller
//
//  Created by Muhammad Omair on 09/04/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation
import UIKit

protocol TableViewHandlerProtocol: UITableViewDataSource, UITableViewDelegate {
    

    func configure(tableView: UITableView)
    func updateData(_ launches: [LaunchListModel])
}
