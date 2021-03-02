//
//  PopularMoviesUseCaseProtocol.swift
//  Domain
//
//  Created by Estaife Lima on 14/09/20.
//

import Foundation

public protocol PopularMoviesUseCaseProtocol {
    func getAllPopularMovies(page: String, completion: @escaping (Result<MovieResults, DomainError>) -> Void)
}
