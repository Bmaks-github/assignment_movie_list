//
//  TransitionableProxy.swift
//  MovieList
//
//  Created by Maksym Bura on 09.03.2022.
//

import UIKit

public final class TransitionableProxy: Transitionable {
    public weak var wrapped: UIViewController?

    public func push(controller: UIViewController, animated: Bool) {
        let navigationController = wrapped?.navigationController ?? wrapped as? UINavigationController
        navigationController?.pushViewController(controller, animated: animated)
    }

    public func pop(animated: Bool) {
        wrapped?.navigationController?.popViewController(animated: animated)
    }
}
