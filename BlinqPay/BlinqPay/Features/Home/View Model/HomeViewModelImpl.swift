//
//  HomeViewModelImpl.swift
//  BlinqPay
//
//  Created by ULU on 22/05/2023.
//

import Foundation

final class HomeViewModelImpl: BaseViewModel, IHomeViewModel {
    
    fileprivate var preference: IPreference
    
    init(preference: IPreference) {
        self.preference = preference
    }
}
