//
//  SimilarMoviesUseCaseProtocol.swift
//  Domain
//
//  Created by Estaife Lima on 31/10/21.
//

import Foundation

public protocol SimilarMoviesUseCaseProtocol {
    func getAllSimilarMovies(identifier: String, completion: @escaping (Result<MovieResults, DomainError>) -> Void)
}
