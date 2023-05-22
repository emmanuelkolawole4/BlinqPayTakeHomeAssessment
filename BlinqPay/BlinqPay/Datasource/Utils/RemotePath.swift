//
//  RemotePath.swift
//  BlinqPay
//
//  Created by ULU on 22/05/2023.
//

import Foundation

enum RemotePath {
    
    case login
    
    var desc: String {
        switch self {
        case .login:
            return "auth/login"
        }
    }
    
//    var requestURL: String { "\(Bundle.main.baseURL)\(desc)" }
}
