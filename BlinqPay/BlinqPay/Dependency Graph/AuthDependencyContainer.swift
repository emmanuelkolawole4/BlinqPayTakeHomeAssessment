//
//  AuthDependencyContainer.swift
//  BlinqPay
//
//  Created by ULU on 22/05/2023.
//

import Foundation
import Swinject

@available(iOS 13.0, *)
struct AuthDependencyContainer {
    
    static func configure(using container: Container) {
        
        container.register(IAuthRemoteDatasource.self) { _ in AuthRemoteDatasourceImpl() }
        
        container.register(IAuthViewModel.self) { AuthViewModelImpl(preference: $0.resolve(IPreference.self)!, authRemote: $0.resolve(IAuthRemoteDatasource.self)!) }
        
        container.register(LogInViewController.self) { LogInViewController(viewModel: $0.resolve(IAuthViewModel.self)!) }
    }
}
