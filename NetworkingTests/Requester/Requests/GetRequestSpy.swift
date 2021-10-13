//
//  GetRequestSpy.swift
//  NetworkingTests
//
//  Created by Estaife Lima on 13/10/21.
//

import Data

struct GetRequestSpy: RequestProtocol {
    var path: String {
        "/anyGet"
    }
    var method: HTTPMethod {
        .get
    }
    var body: Data?
    var parameters: [String : String]?
    var headers: [String : String]?
}
