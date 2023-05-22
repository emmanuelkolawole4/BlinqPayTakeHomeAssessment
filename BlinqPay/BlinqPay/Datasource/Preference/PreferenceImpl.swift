//
//  PreferenceImpl.swift
//  BlinqPay
//
//  Created by ULU on 17/05/2023.
//

import Foundation

struct PreferenceImpl: IPreference {
    
    @UserDefaultPrimitive(key: PreferenceConstants.ACCESS_TOKEN, default: "")
    var accessToken: String
}
