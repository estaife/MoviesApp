//
//  SimilarMoviesRequest.swift
//  Data
//
//  Created by Estaife Lima on 31/10/21.
//

import Core

struct SimilarMoviesRequest {
    let identifier: String
    let language: String
    
    init(identifier: String, language: String) {
        self.identifier = identifier
        self.language = language
    }
}

extension SimilarMoviesRequest: RequestProtocol {
    var path: String {
        "/movie/\(identifier)/similar"
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var body: Data? {
        nil
    }
    
    var parameters: [String : String]? {
        [
            TMDBParameterKey.apiKey.rawValue : Environment().apiKey,
            TMDBParameterKey.language.rawValue : language
        ]
    }
    
    var headers: [String : String]? {
        nil
    }
}
