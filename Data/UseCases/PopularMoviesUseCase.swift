//
//  PopularMoviesUseCase.swift
//  Data
//
//  Created by Estaife Lima on 14/09/20.
//

import Domain

public final class PopularMoviesUseCase {
    private let requesterHTTP: RequesterHTTPProtocol
    private let locate: LocateUseCaseProtocol
    
    public init(requesterHTTP: RequesterHTTPProtocol, locate: LocateUseCaseProtocol) {
        self.requesterHTTP = requesterHTTP
        self.locate = locate
    }
}

// MARK: - PopularMoviesUseCaseProtocol
extension PopularMoviesUseCase: PopularMoviesUseCaseProtocol {
    public func getAllPopularMovies(
        page: String,
        completion: @escaping (Result<MovieResults, DomainError>) -> Void
    ) {
        requesterHTTP.perform(
            request: PopularMoviesRequest(
                page: page,
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
