//
//  HudWindowViewController.swift
//  MovieList
//
//  Created by Maksym Bura on 09.03.2022.
//

import UIKit

final class HudWindowViewController: UIViewController {
    private var mainRootViewController: UIViewController? {
        let window = UIApplication.shared.keyWindow
        return window?.rootViewController
    }

    override var childForStatusBarStyle: UIViewController? {
        mainRootViewController
    }
}
