//
//  HTTPClient.swift
//  Data
//
//  Created by Estaife Lima on 01/03/21.
//

import Foundation

public protocol HTTPPostClient {
    func post(to url: URL, with data: Data?, completion: @escaping (Result<Data?, HTTPError>) -> Void)
}

public protocol HTTPGetClient {
    func get(from url: URL, completion: @escaping (Result<Data?, HTTPError>) -> Void)
}
