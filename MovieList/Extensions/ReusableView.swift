//
//  ReusableView.swift
//  MovieList
//
//  Created by Maksym Bura on 07.03.2022.
//

import UIKit

protocol ReusableView: AnyObject {}

extension ReusableView where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
