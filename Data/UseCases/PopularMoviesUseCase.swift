//
//  PopularMoviesUseCase.swift
//  Data
//
//  Created by Estaife Lima on 14/09/20.
//

import Domain

public final class PopularMoviesUseCase {
    public init() { }
}

extension PopularMoviesUseCase: PopularMoviesUseCaseProtocol {
    public func getAllPopularMovies(page: String, completion: @escaping (Result<MovieResults, DomainError>) -> Void) {
        //TODO: - Handle promise
    }
}
