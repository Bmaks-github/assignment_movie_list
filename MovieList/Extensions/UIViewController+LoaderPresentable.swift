//
//  UIViewController+LoaderPresentable.swift
//  MovieList
//
//  Created by Maksym Bura on 09.03.2022.
//

import UIKit
import MBProgressHUD

extension UIViewController: LoaderPresentable {
    func setLoading(_ loading: Bool) {
        HudHelper.shared.set(isLoading: loading)
    }
}
