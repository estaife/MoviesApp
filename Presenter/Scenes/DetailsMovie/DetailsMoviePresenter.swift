//
//  DetailsMoviePresenter.swift
//  Presenter
//
//  Created by Estaife Lima on 25/10/21.
//

import Foundation

import Foundation
import Domain

public protocol DetailsMoviePresenterProtocol: AnyObject {
    func presentDetailMovie(_ movie: MovieViewModel)
    func presentError(_ error: DomainError)
}

final public class DetailsMoviePresenter {
    
    // MARK: - Properties
    private let identifier: String
    private let detailsMovieUseCase: DetailsMovieUseCaseProtocol
    private let loadingView: LoadingViewProtocol
    private let delegate: DetailsMoviePresenterProtocol
    
    // MARK: - Init
    public init(
        identifier: String
        detailsMovieUseCase: DetailsMovieUseCaseProtocol,
        loadingView: LoadingViewProtocol,
        delegate: PopularMoviesPresenterProtocol
    ) {
        self.popularMoviesUseCase = popularMoviesUseCase
        self.loadingView = loadingView
        self.delegate = delegate
    }
    
    // MARK: - PUBLIC METHODS
    public func fetchDetailMovie() {
        loadingView.start()
        
        detailsMovieUseCase.getDetailsMovie(identifier: identifier) { [weak self] result in
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
    
    // MARK: - PRIVATE METHODS
    private func handleSuccess(_ movieResults: MovieResults) {
        
    }
}
