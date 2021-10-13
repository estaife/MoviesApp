//
//  PopularMoviesRequest.swift
//  Data
//
//  Created by Estaife Lima on 13/10/21.
//

import Foundation

struct PopularMoviesRequest: RequestProtocol {
    var path: String {
        "/movie/popular"
    }
    var method: HTTPMethod {
        .get
    }
    var body: Data?
    
    var parameters: [String : String]? {
        Environment().apiKeyDic
    }
    
    var headers: [String : String]?
}
