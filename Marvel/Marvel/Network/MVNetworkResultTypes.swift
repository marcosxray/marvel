//
//  MVNetworkResultTypes.swift
//  Marvel
//
//  Created by Marcos Borges on 09/04/2018.
//  Copyright © 2018 Marcos Borges. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


// MARK: - Class

class MVNetworkRequestError {
    var statusCode: Int
    var message: String?
    var body: [String: Any]?
    
    init(_ message: String?, statusCode: Int, body: [String: Any]? = nil) {
        self.message = message
        self.statusCode = statusCode
        self.body = body
    }
}

class MVNetworkRequestSuccess {
    var statusCode: Int
    var body: [String: Any]?
    
    init(body: [String: Any]?, statusCode: Int) {
        self.body = body
        self.statusCode = statusCode
    }
}
