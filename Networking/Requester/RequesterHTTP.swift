//
//  RequesterHTTPProtocol.swift
//  Networking
//
//  Created by Estaife Lima on 02/03/21.
//

import Foundation
import Alamofire
import Domain
import Data

public final class RequesterHTTP {
    private let session: Session
    
    public init(session: Session = .default) {
        self.session = session
    }
    
    private func handleSuccessWith<ResponseType: Codable>(
        statusCode: Int,
        data: Data,
        type: ResponseType.Type
    ) -> Result<ResponseType, DomainError> {
        switch statusCode {
        case 204:
            return .failure(.init(internalError: .noData))
        case 200...299:
            do {
                let decoder = JSONDecoder()
                let responseType = try decoder.decode(type.self, from: data)
                return .success(responseType)
            } catch let parseError {
                return .failure(.init(rawError: parseError))
            }
        case 401:
            return .failure(.init(internalError: .unauthorized))
        case 403:
            return .failure(.init(internalError: .forbidden))
        case 300...399:
            return .failure(.init(internalError: .noConnectivity))
        case 404:
            return .failure(.init(internalError: .noData))
        case 400...499:
            return .failure(.init(internalError: .badRequest))
        case 500...599:
            return .failure(.init(internalError: .serverError))
        default:
            return .failure(.init(internalError: .unknown))
        }
    }
}

extension RequesterHTTP: RequesterHTTPProtocol {
    public func perform<ResponseType: Codable>(
        request: RequestProtocol,
        type: ResponseType.Type,
        completion: @escaping (Result<ResponseType, DomainError>) -> Void
    ) {
        guard let url = request.url else {
            completion(.failure(.init(internalError: .badRequest)))
            return
        }
        var headers: HTTPHeaders?
        if let headersDic = request.headers {
            headers = HTTPHeaders(headersDic)
        }
        session.request(
            url,
            method: .init(rawValue: request.method.name),
            parameters: request.parameters,
            headers: headers
        ).responseData { [weak self] response in
            if let self = self {
                switch response.result {
                case .success(let data):
                    completion(
                        self.handleSuccessWith(
                            statusCode: response.response?.statusCode ?? -1,
                            data: data,
                            type: type
                        )
                    )
                case .failure(let error):
                    completion(.failure(.init(rawError: error)))
                }
            }
        }
    }
}
