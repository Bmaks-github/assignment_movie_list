//
//  Configurable.swift
//  MovieList
//
//  Created by Maksym Bura on 03.03.2022.
//

import Foundation

public protocol Configurable {}

public extension Configurable {
    func with(config: (inout Self) -> Void) -> Self {
        var this = self
        config(&this)
        return this
    }
}

extension NSObject: Configurable {}
