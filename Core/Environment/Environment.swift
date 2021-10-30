//
//  Environment.swift
//  Data
//
//  Created by Estaife Lima on 13/10/21.
//

import Foundation

final public class Environment {
    
    public init() { }
    
    private enum EnvironmentKey: String {
        case baseURL = "TMDB_API_BASE_URL"
        case versionAPI = "TMDB_API_VERSION"
        case keyAPI = "TMDB_API_KEY"
        case imageURL = "TMDB_API_IMAGE_URL"
    }
    
    private func variable(with key: EnvironmentKey) -> String {
        if let infoDictionary = BundleModule.bundle.infoDictionary,
            let value = infoDictionary[key.rawValue] as? String {
            return value
        }
        return ""
    }
    
    public var baseURLString: String {
        variable(with: .baseURL) + variable(with: .versionAPI)
    }

    public var apiKey: String {
        variable(with: .keyAPI)
    }
    
    public var baseImageURLString: String {
        variable(with: .imageURL)
    }
}
