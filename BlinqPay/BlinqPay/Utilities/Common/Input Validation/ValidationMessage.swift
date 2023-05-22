//
//  ValidationMessage.swift
//  BlinqPay
//
//  Created by ULU on 17/05/2023.
//

import Foundation

struct ValidationMessage {
    var isValid: Bool = false
    let message: String
    let validationType: ValidationType
}
