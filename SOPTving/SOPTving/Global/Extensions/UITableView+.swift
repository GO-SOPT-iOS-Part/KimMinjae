//
//  UITableView+.swift
//  SOPTving
//
//  Created by 김민재 on 2023/05/05.
//

import UIKit

//protocol UITableViewCellReusableProtocol where Self: UITableViewCell {
//    static func dequeueReusableCell(from tableView: UITableView, indexPath: IndexPath) -> Self {
//        tableView.
//    }
//}


extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(withType cellType: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.className, for: indexPath) as? T else {
            fatalError("Could not find cell with reuseID \(T.className)")
        }
        return cell
    }

    func register<T>(cell: T.Type,
                      forCellReuseIdentifier reuseIdentifier: String = T.className) where T: UITableViewCell {
        register(cell, forCellReuseIdentifier: reuseIdentifier)
    }
}
