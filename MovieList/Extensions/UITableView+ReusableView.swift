//
//  UITableView+ReusableView.swift
//  MovieList
//
//  Created by Maksym Bura on 07.03.2022.
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(_ type: T.Type) {
        register(type, forCellReuseIdentifier: type.reuseIdentifier)
    }

    func dequeueReusableCell<T: UITableViewCell>() -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier) as? T else {
            assertionFailure("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
            register(T.self)
            return dequeueReusableCell()
        }
        return cell
    }
}
