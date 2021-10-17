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
    var completion: ((Result<MovieResults, DomainError>) -> Void)?
    
    func perform<ResponseType: Codable>(
        request: RequestProtocol,
        type: ResponseType.Type,
        completion: @escaping (Result<ResponseType, DomainError>) -> Void
    ) {
        self.url = request.url
        self.request = request
        self.completion = (completion as? (Result<MovieResults, DomainError>) -> Void)
    }
    
    func completeWith(error: DomainError) {
        completion?(.failure(error))
    }
    
    func completeWith(data: MovieResults) {
        completion?(.success(data))
    }
}
