//
//  HTTPGetClientSpy.swift
//  DataTests
//
//  Created by Estaife Lima on 01/03/21.
//

import Data

final class HTTPGetClientSpy: HTTPGetClient {
    var url = [URL]()
    var completion: ((Result<Data?, HTTPError>) -> Void)?
    
    public func get(from url: URL, completion: @escaping (Result<Data?, HTTPError>) -> Void) {
        self.url.append(url)
        self.completion = completion
    }
    
    func completeWith(error: HTTPError) {
        completion?(.failure(.unknown))
    }
    
    func completeWith(data: Data) {
        completion?(.success(data))
    }
}
