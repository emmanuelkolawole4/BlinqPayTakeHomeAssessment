//
//  AuthRemoteDatasourceImpl.swift
//  BlinqPay
//
//  Created by ULU on 22/05/2023.
//

import Foundation
import RxSwift
import Alamofire

class AuthRemoteDatasourceImpl: BaseRemoteDatasource, IAuthRemoteDatasource {
    
    func signin(params: Parameters) -> Observable<BPUserResponse> {
//        makeAPIRequest(path: .login, responseType: BPUserResponse.self, method: .post, params: params)
        makeAPIRequest(path: "login", responseType: BPUserResponse.self, method: .post, params: params)
    }
    
}
