//
//  SceneDelegate.swift
//  BlinqPay
//
//  Created by ULU on 16/05/2023.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        makeWindow(withScene: windowScene)
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
    
    private func makeWindow(withScene windowScene: UIWindowScene) {
        let window = UIWindow(windowScene: windowScene)
        let rootViewController = AppDelegate.dependencyContainer.logInController
        
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        self.window = window
    }

    private func setupTabbarController() {
        UITabBar.appearance().barTintColor = .white
        UITabBar.appearance().tintColor = .primaryGreen
    }
}

import SwiftUI

@available(iOS 13.0.0, *)
struct PreviewViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            DashboardTabController()
        }
    }
}

@available(iOS 13.0, *)
struct ViewControllerPreview: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UIViewController
    
    
    let viewControllerBuilder: () -> UIViewController

    init(_ viewControllerBuilder: @escaping () -> UIViewController) {
        self.viewControllerBuilder = viewControllerBuilder
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        return viewControllerBuilder()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // Not needed
    }
    
}
