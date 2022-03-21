//
//  HudWindowViewController.swift
//  MovieList
//
//  Created by Maksym Bura on 09.03.2022.
//

import UIKit

final class HudWindowViewController: UIViewController {
    private var mainRootViewController: UIViewController? {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return nil }
        
        let window = UIWindow(windowScene: windowScene)
        
        return window.rootViewController
    }

    override var childForStatusBarStyle: UIViewController? {
        mainRootViewController
    }
}
