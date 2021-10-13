//
//  PopularMoviesUseCase.swift
//  Data
//
//  Created by Estaife Lima on 14/09/20.
//

import Domain

public final class PopularMoviesUseCase {
    private let request: RequestProtocol
    private let requesterHTTP: RequesterHTTPProtocol
    
    public init(requesterHTTP: RequesterHTTPProtocol) {
        self.requesterHTTP = requesterHTTP
        self.request = PopularMoviesRequest()
    }
}

extension PopularMoviesUseCase: PopularMoviesUseCaseProtocol {
    public func getAllPopularMovies(page: String, completion: @escaping (Result<MovieResults, DomainError>) -> Void) {
        requesterHTTP.perform(request: request, type: MovieResults.self) { result in
            switch result {
            case .success(let movieResults):
                completion(.success(movieResults))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
