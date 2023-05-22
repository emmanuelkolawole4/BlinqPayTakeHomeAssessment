//
//  IInputValidator.swift
//  BlinqPay
//
//  Created by ULU on 17/05/2023.
//

import Foundation

protocol IInputValidator {
    
    func validateEmailAddress(_ email: String) -> ValidationMessage
    
    func validateEmailOrPhone(_ emailOrPhone: String) -> ValidationMessage
    
    func validatePhoneNumber(_ phoneNo: String) -> ValidationMessage
    
    func validateName(_ name: String) -> ValidationMessage
    
    func validateAddress(_ address: String) -> ValidationMessage
    
    func validatePassword(_ password: String) -> ValidationMessage
    
    func validateConfirmPassword(_ password: String, _ confirmPassword: String) -> ValidationMessage
    
    func validate(_ value: String, for type: ValidationType) -> ValidationMessage
    
    func validateAmount(_ amount: String) -> ValidationMessage
    
    func validateMileage(_ value: String, max: Double) -> ValidationMessage
    
}
