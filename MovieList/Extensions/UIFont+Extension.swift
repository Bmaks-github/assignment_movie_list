//
//  UIFont+Extension.swift
//  MovieList
//
//  Created by Maksym Bura on 15.03.2022.
//

import UIKit

extension UIFont {
    static var mlStandardBoldFont: UIFont {
        return .systemFont(ofSize: 17, weight: .bold)
    }

    static var mlStandardHeavyFont: UIFont {
        return .systemFont(ofSize: 17, weight: .heavy)
    }

    static var mlHeaderFont: UIFont {
        return .systemFont(ofSize: 25, weight: .bold)
    }
    
    static var mlStandardFont: UIFont {
        return .systemFont(ofSize: 16)
    }
    
    static var mlSecondaryMediumFont: UIFont {
        return .systemFont(ofSize: 12, weight: .medium)
    }

    static var mlSecondarySemiBoldFont: UIFont {
        return .systemFont(ofSize: 15, weight: .semibold)
    }
}
