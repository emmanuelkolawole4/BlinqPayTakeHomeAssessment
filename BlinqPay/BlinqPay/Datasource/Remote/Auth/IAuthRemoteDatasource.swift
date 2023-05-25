//
//  IAuthRemoteDatasource.swift
//  BlinqPay
//
//  Created by ULU on 22/05/2023.
//

import Foundation
import RxSwift
import Alamofire

protocol IAuthRemoteDatasource {
    func createUser(params: Parameters, completion: @escaping ((Result<AuthNavRoute, Error>) -> Void))
}


struct BPUserResponse: Codable {
    
}
