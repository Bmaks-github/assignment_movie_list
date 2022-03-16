//
//  Transitionable.swift
//  MovieList
//
//  Created by Maksym Bura on 09.03.2022.
//

import UIKit

// sourcery: AutoMockable
protocol Transitionable: AnyObject {
    func push(controller: UIViewController, animated: Bool)
    func pop(animated: Bool)
}
