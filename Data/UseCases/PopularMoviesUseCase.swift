//
//  PopularMoviesUseCase.swift
//  Data
//
//  Created by Estaife Lima on 14/09/20.
//

import Domain

public final class PopularMoviesUseCase {
    private let url: URL
    private let httpGetClient: HTTPGetClient
    
    public init(httpGetClient: HTTPGetClient, url: URL) {
        self.httpGetClient = httpGetClient
        self.url = url
    }
    
    private func handleSuccess(_ data: Data?) -> Result<MovieResults, DomainError> {
        if let model: MovieResults = data?.convertToModel() {
            return .success(model)
        }
        return .failure(.convert)
    }
}

extension PopularMoviesUseCase: PopularMoviesUseCaseProtocol {
    public func getAllPopularMovies(page: String, completion: @escaping (Result<MovieResults, DomainError>) -> Void) {
        httpGetClient.get(from: url) { [weak self] result in
            if let self = self {
                switch result {
                case .success(let data):
                    completion(self.handleSuccess(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
