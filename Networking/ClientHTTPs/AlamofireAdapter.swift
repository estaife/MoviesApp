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
    
    private func handleSuccssesWith(statusCode: Int, and data: Data?) -> Result<Data?, DomainError> {
        switch statusCode {
        case 204: return .success(nil)
        case 200...299: return .success(data)
        case 401: return .failure(.unauthorized)
        case 403: return .failure(.forbidden)
        case 300...399: return .failure(.noConnectivity)
        case 404: return .failure(.noData)
        case 400...499: return .failure(.badRequest)
        case 500...599: return .failure(.serverError)
        default: return .failure(.unknown)
        }
    }
}

extension AlamofireAdapter: HTTPPostClient {
    public func post(to url: URL, with data: Data?, completion: @escaping (Result<Data?, DomainError>) -> Void) {
        session.request(url, method: .post, parameters: data?.json).responseData { [weak self] response in
            if let self = self, let statusCode = response.response?.statusCode {
                switch response.result {
                case .success(let data):
                    completion(self.handleSuccssesWith(statusCode: statusCode, and: data))
                case .failure: completion(.failure(.unknown))
                }
            }
        }
    }
}

extension AlamofireAdapter: HTTPGetClient {
    public func get(from url: URL, completion: @escaping (Result<Data?, DomainError>) -> Void) {
        session.request(url, method: .get).responseData { [weak self] response in
            if let self = self, let statusCode = response.response?.statusCode {
                switch response.result {
                case .success(let data):
                    completion(self.handleSuccssesWith(statusCode: statusCode, and: data))
                case .failure: completion(.failure(.unknown))
                }
            } else {
                return completion(.failure(.unknown))
            }
        }
    }
}
