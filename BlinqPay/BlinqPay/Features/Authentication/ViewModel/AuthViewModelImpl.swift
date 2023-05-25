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
    
    func login(with username: String) {
        let params = [
            "bio": "Always curious to learn new stuff",
            "name": "Brooklyn Simmons",
            "photo": "https://firebasestorage.googleapis.com/vo/b/blynq-13e9a.appspot.com/o/default_user_img.png?alt=media&token=8190d4c3-8a93-4476-a37b-bc3faa74e71d",
            "userId": "2tJgiVZWQRczkDqqjzrG",
            "username": username
        ]
        
        authRemote.createUser(params: params) { [weak self] result in
            switch result {
            case .success(let res):
                self?.authNavRoute.onNext(res)
            case .failure(let error):
                print(error.localizedDescription)
                self?.authErrorMessage.onNext(error.localizedDescription)
            }
        }
    }
    
}
