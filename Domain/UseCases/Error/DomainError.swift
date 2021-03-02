//
//  DomainError.swift
//  Domain
//
//  Created by Estaife Lima on 14/09/20.
//

import Foundation

public enum DomainError: Error {
    case unauthorized
    case forbidden
    case badRequest
    case serverError
    case noConnectivity
    case unknown
    case noData
    case parseError
    case convert
    
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
        case .convert: return "Holve um erro ao converter os dados"
        }
    }
}
