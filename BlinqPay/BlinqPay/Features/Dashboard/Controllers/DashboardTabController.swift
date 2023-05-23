//
//  DashboardController.swift
//  BlinqPay
//
//  Created by ULU on 22/05/2023.
//

import UIKit

@available(iOS 13.0, *)
class DashboardTabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }
    
    private func setupTabs() {
        let homeVC = AppDelegate.dependencyContainer.homeController
        let chatVC = AppDelegate.dependencyContainer.chatListController
        let mediaVC = AppDelegate.dependencyContainer.mediaController //MediaViewController()
        let settingsVC = AppDelegate.dependencyContainer.settingsController //SettingsViewController()
        
        
        let nav1 = UINavigationController(rootViewController: homeVC)
        let nav2 = UINavigationController(rootViewController: chatVC)
        let nav3 = UINavigationController(rootViewController: mediaVC)
        let nav4 = UINavigationController(rootViewController: settingsVC)
        
        nav1.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "house"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "person.2"), tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "camera"), tag: 3)
        nav4.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "gear"), tag: 4)
        
        [homeVC, chatVC, mediaVC, settingsVC].forEach { $0.navigationItem.largeTitleDisplayMode = .automatic }
        [nav1, nav2, nav3, nav4].forEach { $0.navigationBar.prefersLargeTitles = true }
        
        setViewControllers(
            [nav1, nav2, nav3, nav4],
            animated: true)
    }

}
