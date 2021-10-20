//
//  PopularMoviesUseCaseSpy.swift
//  PresenterTests
//
//  Created by Estaife Lima on 17/10/21.
//

import Domain

class PopularMoviesUseCaseSpy {
    
    private var completionResult: Result<MovieResults, DomainError>!
    
    func completionWithSuccess(_ movieResults: MovieResults) {
        completionResult = .success(movieResults)
    }
    
    func completionWithError(_ domainError: DomainError) {
        completionResult = .failure(domainError)
    }
}

extension PopularMoviesUseCaseSpy: PopularMoviesUseCaseProtocol {
    func getAllPopularMovies(page: String, completion: @escaping (Result<MovieResults, DomainError>) -> Void) {
        completion(completionResult!)
    }
}
