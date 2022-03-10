//
//  HudHelper.swift
//  MovieList
//
//  Created by Maksym Bura on 09.03.2022.
//

import MBProgressHUD

public final class HudHelper: NSObject {
    public static let shared = HudHelper()

    private var currentHud: MBProgressHUD
    private var hudWindow: UIWindow!
    private var counter: Int = 0

    public func set(isLoading: Bool) {
        isLoading
            ? showHud()
            : dismissHud()
    }

    // Используется в алертах
    public static var defaultHud: MBProgressHUD {
        let hud = MBProgressHUD()
        hud.mode = .indeterminate
//        hud.label.text = L10n.Hud.Label.Title.loading
//        hud.detailsLabel.text = L10n.Hud.Label.detail

        return hud
    }

    // MARK: - Lifecycle

    override private init() {
        hudWindow = UIWindow(windowScene: UIApplication.shared.connectedScenes.first as! UIWindowScene)
//        hudWindow = UIWindow(frame: UIScreen.main.bounds)
//        if let currentWindowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
//            hudWindow = UIWindow(windowScene: currentWindowScene)
//        }
        
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
//        hud.backgroundColor = .gray
//        hud.backgroundView.backgroundColor = .red
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
    public func hudWasHidden(_: MBProgressHUD) {
        if counter <= 0 {
            hudWindow.isHidden = true
        }
    }
}

