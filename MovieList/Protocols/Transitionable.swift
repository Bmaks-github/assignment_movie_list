//
//  Transitionable.swift
//  MovieList
//
//  Created by Maksym Bura on 09.03.2022.
//

import UIKit

public protocol Transitionable: AnyObject {
    func push(controller: UIViewController, animated: Bool)
    func pop(animated: Bool)
}
