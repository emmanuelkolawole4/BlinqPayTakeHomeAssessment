//
//  ValidationType.swift
//  BlinqPay
//
//  Created by ULU on 17/05/2023.
//

import Foundation

enum ValidationType {
    case email, emailOrPhone, phoneNumber, password, confirmPassword, name, amount, numeric, address, mileage(Double), vin(Int), username
}
