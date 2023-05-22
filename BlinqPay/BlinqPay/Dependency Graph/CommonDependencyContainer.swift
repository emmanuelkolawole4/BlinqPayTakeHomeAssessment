//
//  CommonDependencyContainer.swift
//  BlinqPay
//
//  Created by ULU on 22/05/2023.
//

import Foundation
import Swinject

@available(iOS 13.0, *)
struct CommonDependencyContainer {
    
    static func configure(using container: Container) {
        container.register(IPreference.self) { _ in PreferenceImpl() }
    }
    
}
