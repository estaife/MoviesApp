//
//  PopularMoviesUseCaseProtocol.swift
//  Domain
//
//  Created by Estaife Lima on 14/09/20.
//

import Foundation
import Combine

public protocol PopularMoviesUseCaseProtocol {
    func getAllPopularMovies(page: String) -> Future<MovieResults, DomainError>
}
