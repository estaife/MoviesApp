//
//  HTTPGetClientSpy.swift
//  DataTests
//
//  Created by Estaife Lima on 01/03/21.
//

import Data
import Domain

final class RequesterHTTPSpy: RequesterHTTPProtocol {
    var url: URL?
    var request: RequestProtocol?
    
    var success: Codable?
    var error: DomainError?
    
    func perform<ResponseType: Codable>(
        request: RequestProtocol,
        type: ResponseType.Type,
        completion: @escaping (Result<ResponseType, DomainError>) -> Void
    ) {
        self.url = request.url
        self.request = request
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            if let success = self.success {
                completion(.success(success as! ResponseType))
            } else if let error = self.error {
                completion(.failure(error))
            }
        }
    }
}
