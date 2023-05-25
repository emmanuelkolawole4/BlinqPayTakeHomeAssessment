//
//  IAuthViewModel.swift
//  BlinqPay
//
//  Created by ULU on 22/05/2023.
//

import Foundation
import RxSwift

protocol IAuthViewModel {
    
    var authNavRoute: PublishSubject<AuthNavRoute> { get }
    
    var authErrorMessage: PublishSubject<String> { get }
    
    func login(with username: String)
    
}
