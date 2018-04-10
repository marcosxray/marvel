//
//  MVApiRequest.swift
//  Marvel
//
//  Created by Marcos Borges on 09/04/2018.
//  Copyright © 2018 Marcos Borges. All rights reserved.
//

import Foundation
import Alamofire
import CryptoSwift
import RxSwift

// MARK: - Protocol

//protocol MVApiRequest {
//    func getCharacters(offset: Int, count: Int) -> Observable<MVRequestStatus>
//    func getCharacter(url: String) -> Observable<MVRequestStatus>
//}

// MARK: - Class

class MVApiRequest {
    
    // MARK: - Private variables
    
    private var service: MVNetworkService
    
    // MARK: - Initialization
    
    init(networkService: MVNetworkService) {
        self.service = networkService
    }
    
    // MARK: - Public methods
    
    func getCharacters(offset: Int, count: Int) -> Observable<MVRequestStatus> {
        let parameters = apiConfig(offset: offset, limit: count)
        return service.fetch(url: MVAPIRoutes.characters, method: .get, parameters: parameters, headers: apiHeaders())
    }
    
    func getCharacter(url: String) -> Observable<MVRequestStatus> {
        let parameters = apiConfig()
        return service.fetch(url: url, method: .get, parameters: parameters, headers: apiHeaders())
    }
    
    // MARK: - Private methods
    
    private func apiHeaders() -> HTTPHeaders {
        return ["Content-Type": "application/json"]
    }
    
    private func apiConfig(offset: Int? = 0, limit: Int? = 10) -> [String: Any] {
        let ts = Date().timeIntervalSince1970.description
        let apiKey = MVAPIKeys.publicKey
        let hash = "\(ts)\(MVAPIKeys.privateKey)\(apiKey)".md5()
        
        let parameters: [String: Any] = ["apikey": apiKey,
                                         "ts": ts,
                                         "hash": hash,
                                         "offset": offset!,
                                         "limit": limit!]
        
        return parameters
    }
}
