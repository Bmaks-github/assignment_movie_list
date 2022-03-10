//
//  Error+Extension.swift
//  MovieList
//
//  Created by Maksym Bura on 08.03.2022.
//

import Foundation

extension NSError {
    private static let domain = "ML"
    private static let defaultErrorMessage = "Something went wrong"

    static var commonError: NSError {
        NSError.localizedError(withDescription: defaultErrorMessage)
    }
    
    static func localizedError(withDescription description: String) -> NSError {
        return localizedError(withCode: -1, andDescription: description)
    }
    
    static func localizedError(withCode code: Int, andDescription description: String) -> NSError {
        let userInfo: [String: Any] = [NSLocalizedDescriptionKey: description]
        return NSError(domain: domain, code: code, userInfo: userInfo)
    }
}
