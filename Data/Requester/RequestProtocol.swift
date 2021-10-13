//
//  RequestProtocol.swift
//  Networking
//
//  Created by Estaife Lima on 12/10/21.
//

import Foundation

public protocol RequestProtocol {
    var path: String { get }
    var method: HTTPMethod { get }
    var body: Data? { get }
    var parameters: [String: String]? { get }
    var headers: [String: String]? { get }
}

public enum HTTPMethod: String {
    case get
    case post
    
    public var name: String {
        return self.rawValue.uppercased()
    }
}

public extension RequestProtocol {
    var url: URL? {
        let environment = Environment()
        guard let url = URL(string: environment.baseURLString + path) else {
            debugPrint("Fails to create a valid URL")
            return nil
        }
        return url
    }
}

public extension Encodable {
    func convertToData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
}
