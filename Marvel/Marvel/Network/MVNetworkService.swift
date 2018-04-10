//
//  MVNetworkService.swift
//  Marvel
//
//  Created by Marcos Borges on 09/04/2018.
//  Copyright © 2018 Marcos Borges. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import RxSwift

// MARK: - Definitions

enum MVRequestStatus {
    case none
    case downloading
    case success(_: MVNetworkRequestSuccess)
    case error(_: MVNetworkRequestError)
}

// MARK: - Protocol

protocol MVNetworkService {
    func fetch(url: String,
               method: HTTPMethod,
               parameters: Parameters?,
               headers: HTTPHeaders?) -> Observable<MVRequestStatus>
}

// MARK: - Class

class MVNetworkServiceImplementation: MVNetworkService {
    
    func fetch(url: String,
               method: HTTPMethod,
               parameters: Parameters? = nil,
               headers: HTTPHeaders? = [:]) -> Observable<MVRequestStatus> {
        
        return Observable<MVRequestStatus>.create { observer in
            
            observer.onNext(.downloading)
            
            let request = Alamofire.request(url, method: method, parameters: parameters, headers: headers)
            
            request.responseJSON { (dataRes) in
                
                let statusCode = dataRes.response?.statusCode ?? 500
                
                switch dataRes.result {
                case .success(let response):
                    if  let responseDict = response as? [String: Any] {
                        let result = MVNetworkRequestSuccess.init(body: responseDict, statusCode: statusCode)
                        observer.onNext(.success(result))
                        observer.onCompleted()
                    }
                case .failure(let error):
                    let error = MVNetworkRequestError.init(error.localizedDescription, statusCode: statusCode, body: nil)
                    observer.onNext(.error(error))
                    observer.onCompleted()
                    return
                }
            }
            
            return Disposables.create()
        }
    }
}
