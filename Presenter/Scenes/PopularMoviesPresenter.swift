//
//  PopularMoviesPresenter.swift
//  Presenter
//
//  Created by Estaife Lima on 11/10/21.
//

import Foundation
import Domain

public protocol PopularMoviesPresenterProtocol: AnyObject {
    func presentPopularMovies(_ movies: [SimpleMovieResponse])
    func presentError(_ error: DomainError)
}

final public class PopularMoviesPresenter {
    
    // MARK: - Properties
    private let popularMoviesUseCase: PopularMoviesUseCaseProtocol
    public weak var delegate: PopularMoviesPresenterProtocol?
    
    // MARK: - Init
    public init(popularMoviesUseCase: PopularMoviesUseCaseProtocol) {
        self.popularMoviesUseCase = popularMoviesUseCase
    }

    public func getPopularMovies(page: String) {
        popularMoviesUseCase.getAllPopularMovies(page: page) { [weak self] result in
            if let delegate = self?.delegate {
                switch result {
                case .success(let movieResults):
                    delegate.presentPopularMovies(movieResults.results)
                case .failure(let error):
                    delegate.presentError(error)
                }
            }
        }
    }
}
