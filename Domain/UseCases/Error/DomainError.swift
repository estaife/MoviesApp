//
//  DomainError.swift
//  Domain
//
//  Created by Estaife Lima on 14/09/20.
//

import Foundation

public struct DomainError: Error {
    
    public let statusCode: Int
    public let serializedError: SerializedError?
    public var errorInternal: Internal?
    
    public init(statusCode: Int, serializedError: SerializedError?) {
        self.statusCode = statusCode
        self.serializedError = serializedError
    }
    
    public init(internalError: DomainError.Internal) {
        statusCode = internalError.statusCode
        errorInternal = internalError
        serializedError = nil
    }
    
    public init(rawError: Error) {
        let nsError = rawError as NSError
        statusCode = nsError.code
        serializedError = nil
    }
}

extension DomainError: Equatable {
    public static func == (lhs: DomainError, rhs: DomainError) -> Bool {
        lhs.statusCode == rhs.statusCode
    }
}

public extension DomainError {
    enum Internal: Error {
        case unauthorized
        case forbidden
        case badRequest
        case serverError
        case noConnectivity
        case unknown
        case noData
        case parseError

        public var statusCode: Int {
            switch self {
            case .unknown: return 1
            case .noData: return 2
            case .parseError: return 3
            case .unauthorized: return 4
            case .forbidden: return 5
            case .badRequest: return 6
            case .serverError: return 7
            case .noConnectivity: return 8
            }
        }
        
        public var description: String {
            switch self {
            case .unknown: return "Holve um erro desconhecido"
            case .noData: return "Holve um erro na resposta do servidor"
            case .parseError: return "Holve um erro interno"
            case .unauthorized: return "Não autorizado"
            case .forbidden: return "Requisição proibida"
            case .badRequest: return "Requisição não permitido"
            case .serverError: return "Holve um erro no servidor"
            case .noConnectivity: return "Sem Conexão"
            }
        }
    }
}

public struct SerializedError: Decodable {
    let statusCode: Int
    let statusMessage: String
    let success: Bool

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case statusMessage = "status_message"
        case success
    }
}

extension SerializedError: LocalizedError {
    public var errorDescription: String? {
        return statusMessage
    }
}
