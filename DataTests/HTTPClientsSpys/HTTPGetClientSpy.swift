//
//  HTTPGetClientSpy.swift
//  DataTests
//
//  Created by Estaife Lima on 01/03/21.
//

import Data
import Domain

final class HTTPGetClientSpy: HTTPGetClient {
    var url = [URL]()
    var completion: ((Result<Data?, DomainError>) -> Void)?
    
    public func get(from url: URL, completion: @escaping (Result<Data?, DomainError>) -> Void) {
        self.url.append(url)
        self.completion = completion
    }
    
    func completeWith(error: DomainError) {
        completion?(.failure(error))
    }
    
    func completeWith(data: Data) {
        completion?(.success(data))
    }
}
