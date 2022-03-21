//
//  TableViewAdaptableModelProtocol.swift
//  MovieList
//
//  Created by Maksym Bura on 07.03.2022.
//

import UIKit

protocol TableViewAdaptableModelProtocol: Any {
    func cell(at path: IndexPath, for tableView: UITableView) -> UITableViewCell
}
