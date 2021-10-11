//
//  AlamofireAdapter.swift
//  Networking
//
//  Created by Estaife Lima on 02/03/21.
//

import Foundation
import Alamofire
import Domain
import Data

public final class AlamofireAdapter {
    private let session: Session
    
    public init(session: Session = .default) {
        self.session = session
    }
    
    private func handleSuccessWith(statusCode: Int, and data: Data?) -> Result<Data?, DomainError> {
        switch statusCode {
        case 204:
            return .success(nil)
        case 200...299:
            return .success(data)
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

extension AlamofireAdapter: HTTPPostClient {
    public func post(to url: URL, with data: Data?, completion: @escaping (Result<Data?, DomainError>) -> Void) {
        session.request(url, method: .post, parameters: data?.json).responseData { [weak self] response in
            if let self = self, let statusCode = response.response?.statusCode {
                switch response.result {
                case .success(let data):
                    completion(self.handleSuccessWith(statusCode: statusCode, and: data))
                case .failure:
                    completion(.failure(.init(internalError: .unknown)))
                }
            }
        }
    }
}

extension AlamofireAdapter: HTTPGetClient {
    public func get(from url: URL, completion: @escaping (Result<Data?, DomainError>) -> Void) {
        session.request(url, method: .get, parameters: .init(dictionaryLiteral: ("api_key", "8b743bf189292c45c19e1645ad0b4be7"))) // TODO: - Remove mocekd parameters values
            .responseData { [weak self] response in
            if let self = self {
                if let statusCode = response.response?.statusCode {
                    switch response.result {
                    case .success(let data):
                        completion(self.handleSuccessWith(statusCode: statusCode, and: data))
                    case .failure(let error):
                        completion(.failure(.init(rawError: error)))
                    }
                } else if let data = response.data {
                    completion(self.handleSuccessWith(statusCode: 204, and: data))
                } else {
                    return completion(.failure(.init(internalError: .unknown)))
                }
            } else {
                print("ddd")
            }
        }
    }
}
