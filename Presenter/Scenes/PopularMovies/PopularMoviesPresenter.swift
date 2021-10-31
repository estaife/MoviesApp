//
//  PopularMoviesPresenter.swift
//  Presenter
//
//  Created by Estaife Lima on 11/10/21.
//

import Foundation
import Domain

public protocol PopularMoviesPresenterDelegate: AnyObject {
    func presentPopularMovies(_ movies: [MovieViewModel])
    func presentError(_ error: DomainError)
}

final public class PopularMoviesPresenter {
    
    // MARK: - Properties
    private let popularMoviesUseCase: PopularMoviesUseCaseProtocol
    private let loadingView: LoadingViewProtocol
    private let delegate: PopularMoviesPresenterDelegate
    
    // MARK: - Properties Controller
    private var page: Int = 0
    private var totalPages: Int = 1
    
    // MARK: - Init
    public init(
        popularMoviesUseCase: PopularMoviesUseCaseProtocol,
        loadingView: LoadingViewProtocol,
        delegate: PopularMoviesPresenterDelegate
    ) {
        self.popularMoviesUseCase = popularMoviesUseCase
        self.loadingView = loadingView
        self.delegate = delegate
    }

    // MARK: - PUBLIC METHODS
    public func fetchPopularMovies() {
        loadingView.start()
        makePageIncrement()
        let rangeMakeFetch = Range(1...totalPages)
        if rangeMakeFetch.contains(page) {
            makeFetchPopularMovies()
        } else {
            delegate.presentError(DomainError(internalError: .maximumPagesReached))
        }
    }
    
    // MARK: - PRIVATE METHODS
    private func makePageIncrement() {
        page += 1
    }
    
    private func makeFetchPopularMovies() {
        popularMoviesUseCase.getAllPopularMovies(page: String(page)) { [weak self] result in
            if let self = self {
                self.loadingView.stop()
                switch result {
                case .success(let movieResults):
                    self.handleSuccess(movieResults)
                case .failure(let error):
                    self.delegate.presentError(error)
                }
            }
        }
    }
    
    private func handleSuccess(_ movieResults: MovieResults) {
        totalPages = movieResults.totalPages
        
        let popularMoviesViewModel = movieResults.results.map { simpleMovieResponse in
            MovieViewModel(
                identifier: String(simpleMovieResponse.identifier),
                title: simpleMovieResponse.title,
                releaseDate: simpleMovieResponse.releaseDate,
                voteAverage: simpleMovieResponse.voteAverage,
                posterPathString: simpleMovieResponse.posterPath
            )
        }
        delegate.presentPopularMovies(popularMoviesViewModel)
    }
}
