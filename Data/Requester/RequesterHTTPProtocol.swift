//
//  RequesterHTTPProtocol.swift
//  Data
//
//  Created by Estaife Lima on 01/03/21.
//

import Domain

public protocol RequesterHTTPProtocol {
    func perform<ResponseType: Codable>(
        request: RequestProtocol,
        type: ResponseType.Type,
        completion: @escaping (Result<ResponseType, DomainError>) -> Void
    )
}
