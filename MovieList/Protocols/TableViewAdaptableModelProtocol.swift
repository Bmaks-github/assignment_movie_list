//
//  TableViewAdaptableModelProtocol.swift
//  MovieList
//
//  Created by Maksym Bura on 07.03.2022.
//

import UIKit

public protocol TableViewAdaptableModelProtocol: Any {
    func cell(at path: IndexPath, for tableView: UITableView) -> UITableViewCell
    func canSelect() -> Bool
}

public extension TableViewAdaptableModelProtocol {
    func canSelect() -> Bool {
        return true
    }
}
