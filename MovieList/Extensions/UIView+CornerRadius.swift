//
//  UIView+CornerRadius.swift
//  MovieList
//
//  Created by Maksym Bura on 07.03.2022.
//

import UIKit

public extension UIView {
    func setRoundedCorners(_ corners: UIRectCorner = .allCorners, radius: CGFloat) {
        let rect = bounds

        let maskPath = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        let maskLayer = CAShapeLayer()
        maskLayer.frame = rect
        maskLayer.path = maskPath.cgPath

        layer.mask = maskLayer
    }
}
