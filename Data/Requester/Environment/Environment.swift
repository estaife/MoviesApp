//
//  Environment.swift
//  Data
//
//  Created by Estaife Lima on 13/10/21.
//

import Foundation

final class Environment {
    private enum EnvironmentKey: String {
        case baseURL = "TMDB_API_BASE_URL"
        case versionAPI = "TMDB_API_VERSION"
        case keyAPI = "TMDB_API_KEY"
        case imageURL = "TMDB_API_IMAGE_URL"
    }
    
    private func variable(with key: EnvironmentKey) -> String {
        if let infoDictionary = Bundle(for: type(of: self)).infoDictionary,
            let value = infoDictionary[key.rawValue] as? String {
            return value
        }
        return ""
    }
    
    var baseURLString: String {
        variable(with: .baseURL) + variable(with: .versionAPI)
    }

    var apiKey: String {
        variable(with: .keyAPI)
    }
    
    var baseImageURLString: String {
        variable(with: .imageURL)
    }
}
