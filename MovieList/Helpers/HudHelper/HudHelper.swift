//
//  HudHelper.swift
//  MovieList
//
//  Created by Maksym Bura on 09.03.2022.
//

import MBProgressHUD

final class HudHelper: NSObject {
    static let shared = HudHelper()

    private var currentHud: MBProgressHUD
    private var hudWindow: UIWindow!
    private var counter: Int = 0

    func set(isLoading: Bool) {
        isLoading
            ? showHud()
            : dismissHud()
    }

    static var defaultHud: MBProgressHUD {
        let hud = MBProgressHUD()
        hud.mode = .indeterminate

        return hud
    }

    // MARK: - Lifecycle

    override private init() {
        hudWindow = UIWindow(windowScene: UIApplication.shared.connectedScenes.first as! UIWindowScene)
        
        currentHud = MBProgressHUD()
        
        super.init()
        setupWindow()
    }
}

// MARK: - Helpers

private extension HudHelper {
    func setupWindow() {
        hudWindow.backgroundColor = .clear
        hudWindow.windowLevel = .alert

        let viewController = HudWindowViewController()
        viewController.view.backgroundColor = .clear

        hudWindow.rootViewController = viewController
        hudWindow.isHidden = true
    }

    // MARK: - Show Hud

    func showHud() {
        counter = max(0, counter + 1)

        if counter > 1 {
            return
        }

        let hud = MBProgressHUD.showAdded(to: hudWindow, animated: true)
        hud.delegate = self
        hud.mode = .indeterminate
        hud.contentColor = .white
        hud.bezelView.style = .solidColor
        hud.bezelView.color = .clear
        currentHud = hud
        hudWindow.isHidden = false
    }

    // MARK: - Dismiss Hud

    func dismissHud() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.counter = max(0, self.counter - 1)
            if self.counter == 0 {
                self.currentHud.hide(animated: true)
            }
        }
    }
}

extension HudHelper: MBProgressHUDDelegate {
    func hudWasHidden(_: MBProgressHUD) {
        if counter <= 0 {
            hudWindow.isHidden = true
        }
    }
}

