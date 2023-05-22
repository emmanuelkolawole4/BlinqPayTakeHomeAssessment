//
//  BaseRemoteDatasource.swift
//  BlinqPay
//
//  Created by ULU on 22/05/2023.
//

import Foundation
import RxSwift
import Alamofire
import RxAlamofire



class BaseRemoteDatasource {
    
    var preference: IPreference = PreferenceImpl()
    
     fileprivate var headers: HTTPHeaders {
         [.authorization(bearerToken: preference.accessToken)]
     }
     
    /*
     func makeAPIRequest<T>(path: RemotePath, responseType: T.Type, method: HTTPMethod = .get, params: Parameters? = nil, encoding: ParameterEncoding = JSONEncoding.default, headers: HTTPHeaders? = nil) -> Observable<T> where T : Decodable, T : Encodable {
         
         _print("Request URL: \(path.requestURL)", .success)
         _print("Request Parameters:\n \(String(describing: params))", .success)
         
         var _params = params
         if method == .get, _params.isNotNil, preference.language == .french {
             _params = _params! + ["lang":"fr"]
         }
         
         let manager = Session.default
         
         return manager.rx.request(method, path.requestURL, parameters: _params, encoding: encoding, headers: headers ?? self.headers)
             .validate(statusCode: 200 ..< 499)
             .debug()
             .responseString()
             .flatMap { (_, responseString) -> Observable<T> in

                 do {
                     _print(responseString, .success)
                     
                     if let error = try? ACError.mapFrom(jsonString: responseString), error.code.isNotNil {
                         return Observable.error(error)
                     }
                     
                     let requestResponse = try responseType.mapFrom(jsonString: responseString)!
                     return Observable.just(requestResponse)

                 } catch let error {
                     _print(error)
                     throw error
                 }
         }
         .observeOn(MainScheduler.instance)
         
     }
     */
     
     func makeAPIRequest<T>(path: String, responseType: T.Type, method: HTTPMethod = .get, params: Parameters? = nil, encoding: ParameterEncoding = JSONEncoding.default, headers: HTTPHeaders? = nil) -> Observable<T> where T : Decodable, T : Encodable {
         
         _print("Request URL: \(path)", .success)
         _print("Request Parameters:\n \(String(describing: params))", .success)
         
         let manager = Session.default
         
         return manager.rx.request(method, path, parameters: params, encoding: encoding, headers: headers ?? self.headers)
             .validate(statusCode: 200 ..< 499)
             .debug()
             .responseString()
             .flatMap { (_, responseString) -> Observable<T> in

                 do {
                     _print(responseString, .success)
                     
                     if let error = try? BPError.mapFrom(jsonString: responseString), error.code.isNotNil {
                         return Observable.error(error)
                     }
                     
                     let requestResponse = try responseType.mapFrom(jsonString: responseString)!
                     return Observable.just(requestResponse)

                 } catch let error {
                     _print(error)
                     throw error
                 }
         }
         .observeOn(MainScheduler.instance)
         
     }
     
     /*
     func makeFileUploadRequest(fileURL: URL, type: FileUploadType = .image) -> Observable<DocumentUploadResponse> {
         let uploadURL = type.path.requestURL.replacingOccurrences(of: "/v1", with: "")
         _print("Request URL: \(uploadURL)")
         return Observable<DocumentUploadResponse>.create({ observer in
             AF.upload(multipartFormData: { multipartFormData in
                 multipartFormData.append(try! JSONEncoder().encode(true), withName: "public")
                 multipartFormData.append(fileURL, withName: "file")
             }, to: uploadURL, method: .post, headers: self.headers).responseDecodable(of: DocumentUploadResponse.self) { response in
                     if let data = response.data {
                         do {
                             let value = try JSONDecoder().decode(DocumentUploadResponse.self, from: data)
                             _print(value.prettyPrinted, .success, isJsonResponse: true)
                             observer.onNext(value)
                         } catch {
                             _print(error, .error)
                             observer.onError(error)
                         }
                     } else {
                         if let error = response.error {
                             _print(error, .error)
                             observer.onError(error)
                         }
                     }
                     observer.onCompleted()
                 }
             return Disposables.create()
         })
         
     }
     */
}
