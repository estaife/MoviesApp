//
//  DetailsMovieRequest.swift
//  Data
//
//  Created by Estaife Lima on 26/10/21.
//

import Foundation

struct DetailsMovieRequest {
    let identifier: String
    let language: String
    
    init(identifier: String, language: String) {
        self.identifier = identifier
        self.language = language
    }
}

extension DetailsMovieRequest: RequestProtocol {
    var path: String {
        "/movie/\(identifier)"
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
