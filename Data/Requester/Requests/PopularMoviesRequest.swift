//
//  PopularMoviesRequest.swift
//  Data
//
//  Created by Estaife Lima on 13/10/21.
//

import Core

struct PopularMoviesRequest {
    let page: String
    let language: String
    
    init(page: String, language: String) {
        self.page = page
        self.language = language
    }
}

extension PopularMoviesRequest: RequestProtocol {
    var path: String {
        "/movie/popular"
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var body: Data? {
        nil
    }
    
    var parameters: [String : String]? {
        [
            TMDBParameterKey.page.rawValue : page,
            TMDBParameterKey.apiKey.rawValue : Environment().apiKey,
            TMDBParameterKey.language.rawValue : language
        ]
    }
    
    var headers: [String : String]? {
        nil
    }
}
