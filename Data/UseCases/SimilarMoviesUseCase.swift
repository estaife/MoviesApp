//
//  SimilarMoviesUseCase.swift
//  Data
//
//  Created by Estaife Lima on 31/10/21.
//

import Domain

public final class SimilarMoviesUseCase {
    private let requesterHTTP: RequesterHTTPProtocol
    private let locate: LocateUseCaseProtocol
    
    public init(requesterHTTP: RequesterHTTPProtocol, locate: LocateUseCaseProtocol) {
        self.requesterHTTP = requesterHTTP
        self.locate = locate
    }
}

// MARK: - SimilarMoviesUseCaseProtocol
extension SimilarMoviesUseCase: SimilarMoviesUseCaseProtocol {
    public func getAllSimilarMovies(
        identifier: String,
        completion: @escaping (Result<MovieResults, DomainError>) -> Void
    ) {
        requesterHTTP.perform(
            request: SimilarMoviesRequest(
                identifier: identifier,
                language: locate.getCurrentLocate()
            ),
            type: MovieResults.self
        ) { [weak self] result in
            if let _ = self {
                switch result {
                case .success(let movieResults):
                    completion(.success(movieResults))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}

