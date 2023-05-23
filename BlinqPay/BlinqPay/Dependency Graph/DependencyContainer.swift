//
//  DependencyContainer.swift
//  BlinqPay
//
//  Created by ULU on 22/05/2023.
//

import Foundation
import Swinject

@available(iOS 13.0, *)
struct DependencyContainer {
    
    static func configure(using container: Container) {
        CommonDependencyContainer.configure(using: container)
        AuthDependencyContainer.configure(using: container)
        DashboardDependencyContainer.configure(using: container)
    }
}

@available(iOS 13.0, *)
extension Container {
    var logInController: LogInViewController { resolve(LogInViewController.self)! }
    
    var homeController: HomeViewController { resolve(HomeViewController.self)! }
    
    var chatListController: ChatListViewController { resolve(ChatListViewController.self)! }
    
    var chatController: ChatViewController { resolve(ChatViewController.self)! }
    
    var mediaController: HomeViewController { resolve(HomeViewController.self)! }
    
    var settingsController: HomeViewController { resolve(HomeViewController.self)! }
}
