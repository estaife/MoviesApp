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
    private let loadingView: LoadingViewProtocol
    private let delegate: PopularMoviesPresenterProtocol
    
    // MARK: - Properties Controller
    private var page: Int = 0
    private var totalPages: Int = 1
    
    // MARK: - Init
    public init(
        popularMoviesUseCase: PopularMoviesUseCaseProtocol,
        loadingView: LoadingViewProtocol,
        delegate: PopularMoviesPresenterProtocol
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
                    self.totalPages = movieResults.totalPages
                    self.delegate.presentPopularMovies(movieResults.results)
                case .failure(let error):
                    self.delegate.presentError(error)
                }
            }
        }
    }
}
