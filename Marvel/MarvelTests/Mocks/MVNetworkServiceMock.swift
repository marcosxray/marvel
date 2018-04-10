//
//  MVNetworkServiceMock.swift
//  MarvelTests
//
//  Created by Marcos Borges on 10/04/2018.
//  Copyright © 2018 Marcos Borges. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
@testable import Marvel

class MVNetworkServiceSuccessMock: MVNetworkService {
    func fetch(url: String, method: HTTPMethod, parameters: Parameters?, headers: HTTPHeaders?) -> Observable<MVRequestStatus> {
        return Observable<ACRequestStatus>.create { observer in
            let result = MVNetworkRequestSuccess(body: [:], statusCode: 200)
            observer.onNext(.success(result))
            observer.onCompleted()
            return Disposables.create()
        }
    }
}

class MVNetworkServiceFailMock: MVNetworkService {
    func fetch(url: String, method: HTTPMethod, parameters: Parameters?, headers: HTTPHeaders?) -> Observable<MVRequestStatus> {
        return Observable<ACRequestStatus>.create { observer in
            let error = MVNetworkRequestError("Some error has ocurred.", statusCode: 500)
            observer.onNext(.error(error))
            observer.onCompleted()
            return Disposables.create()
        }
    }
}
