//
//  AuthRemoteDatasourceImpl.swift
//  BlinqPay
//
//  Created by ULU on 22/05/2023.
//

import Foundation
import RxSwift
import Alamofire
import FirebaseFirestore

class AuthRemoteDatasourceImpl: BaseRemoteDatasource, IAuthRemoteDatasource {
    
    func createUser(params: Parameters, completion: @escaping ((Result<AuthNavRoute, Error>) -> Void)) {
        FirestoreReferenceManager.root.document().setData(params) { error in
            if let error = error {
                completion(.failure(error))
            }
            else {
                completion(.success(.home))
                print("s u c c e s s")
            }
        }
    }
    
}

struct FirebaseKeys {
    
    struct CollectionPath {
        static let users = "users"
    }
}

struct FirestoreReferenceManager {
    
    static let db = Firestore.firestore()
    static let root = db.collection(FirebaseKeys.CollectionPath.users)
}
