//
//  AuthViewModelImpl.swift
//  BlinqPay
//
//  Created by ULU on 22/05/2023.
//

import Foundation
import RxSwift


class AuthViewModelImpl: BaseViewModel, IAuthViewModel {
    
    var preference: IPreference
    var authErrorMessage = PublishSubject<String>()
    fileprivate let authRemote: IAuthRemoteDatasource
    var authNavRoute: PublishSubject<AuthNavRoute> = PublishSubject()
    
    init(preference: IPreference, authRemote: IAuthRemoteDatasource) {
        self.preference = preference
        self.authRemote = authRemote
    }
    
    override func didAppear() {
        super.didAppear()
//        if preference.user.isNotNil {
//            authNavRoute.onNext(.dashboard)
//        }
    }
    
    func signin(username: String) {
        let params = [
            "username": username
        ]
        subscribe(authRemote.signin(params: params), success: { [weak self] authRes in
            self?.handleAuthenticationResponse(authRes)
        })
    }
    
    fileprivate func handleAuthenticationResponse(_ authRes: BPUserResponse) {
//        let roles = authRes.authority?.roles ?? []
//        if roles.isEmpty || !roles.contains(where: { $0.insensitiveEquals("PARTNER ADMIN") || $0.insensitiveEquals("FRANCHISE ADMIN") }) {
//            authErrorMessage.onNext(.AUTHENTICATION_ROLES_ERROR)
//        } else if authRes.user?.company.isNil ?? false {
//            authErrorMessage.onNext(.AUTHENTICATION_COMPANY_ERROR)
//        } else {
//            preference.user = authRes.user
//            preference.accessToken = authRes.token.orEmpty
//            authNavRoute.onNext(.dashboard)
//        }
    }
}
