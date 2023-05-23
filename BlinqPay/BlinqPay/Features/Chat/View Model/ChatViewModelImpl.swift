//
//  ChatViewModelImpl.swift
//  BlinqPay
//
//  Created by ULU on 23/05/2023.
//

import Foundation

final class ChatViewModelImpl: BaseViewModel, IChatViewModel {
    
    fileprivate var preference: IPreference
    
    init(preference: IPreference) {
        self.preference = preference
    }
}
