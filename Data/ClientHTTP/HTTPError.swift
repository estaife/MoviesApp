//
//  HTTPError.swift
//  Data
//
//  Created by Estaife Lima on 01/03/21.
//

import Foundation

public enum HTTPError: Error {
    case unknown
    case noConnectivity
    case invalidRequest
    case forbidden
    case internalServer
    case unauthorized
    case notFound
    case noData
}
