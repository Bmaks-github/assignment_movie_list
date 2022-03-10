//
//  TableHeaderFooterAdaptableModelProtocol.swift
//  MovieList
//
//  Created by Maksym Bura on 07.03.2022.
//

import UIKit

public protocol TableHeaderFooterViewAdaptableModelProtocol: Any {
    func headerFooter(tableView: UITableView) -> UIView
}
