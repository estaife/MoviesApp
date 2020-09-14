//
//  PopularMoviesUseCase.swift
//  Data
//
//  Created by Estaife Lima on 14/09/20.
//

import Domain
import Combine

public final class PopularMoviesUseCase {
    public init() { }
}

extension PopularMoviesUseCase: PopularMoviesUseCaseProtocol {
    public func getAllPopularMovies(page: String) -> Future<MovieResults, DomainError> {
        Future { promise in
            //TODO: - Handle promise
        }
    }
}
