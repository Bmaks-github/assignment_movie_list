//
//  TransitionableProxy.swift
//  MovieList
//
//  Created by Maksym Bura on 09.03.2022.
//

import UIKit

final class TransitionableProxy: Transitionable {
    weak var wrapped: UIViewController?

    func push(controller: UIViewController, animated: Bool) {
        let navigationController = wrapped?.navigationController ?? wrapped as? UINavigationController
        navigationController?.pushViewController(controller, animated: animated)
    }

    func pop(animated: Bool) {
        let navigationController = wrapped?.navigationController ?? wrapped as? UINavigationController
        navigationController?.popViewController(animated: animated)
    }
}
