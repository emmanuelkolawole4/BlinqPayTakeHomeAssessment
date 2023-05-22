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
    func signin(params: Parameters) -> Observable<BPUserResponse>
}


struct BPUserResponse: Codable {
    
}
