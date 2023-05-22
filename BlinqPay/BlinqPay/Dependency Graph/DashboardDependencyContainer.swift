//
//  DashboardDependencyContainer.swift
//  BlinqPay
//
//  Created by ULU on 22/05/2023.
//

import Foundation
import Swinject

@available(iOS 13.0, *)
struct DashboardDependencyContainer {
    
    static func configure(using container: Container) {
        
        container.register(IHomeViewModel.self) { HomeViewModelImpl(preference: $0.resolve(IPreference.self)!) }
        
        container.register(HomeViewController.self) { HomeViewController(viewModel: $0.resolve(IHomeViewModel.self)!) }
        
    }
    
}
