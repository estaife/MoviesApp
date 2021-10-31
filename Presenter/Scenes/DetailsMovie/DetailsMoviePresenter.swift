//
//  DetailsMoviePresenter.swift
//  Presenter
//
//  Created by Estaife Lima on 25/10/21.
//

import Foundation

import Foundation
import Domain

public protocol DetailsMoviePresenterDelegate: AnyObject {
    func presentDetailsMovie(_ movie: DetailsMovieViewModel)
    func presentError(_ error: DomainError)
}

final public class DetailsMoviePresenter {
    
    // MARK: - Properties
    private let identifier: String
    private let detailsMovieUseCase: DetailsMovieUseCaseProtocol
    private let similarMovieUseCase: SimilarMoviesUseCaseProtocol
    private let loadingView: LoadingViewProtocol
    private let delegate: DetailsMoviePresenterDelegate
    
    private var detailsMovie = CompleteMovieResponse()
    private var similarMovies = [SimpleMovieResponse]()
    
    // MARK: - Init
    public init(
        identifier: String,
        detailsMovieUseCase: DetailsMovieUseCaseProtocol,
        similarMovieUseCase: SimilarMoviesUseCaseProtocol,
        loadingView: LoadingViewProtocol,
        delegate: DetailsMoviePresenterDelegate
    ) {
        self.identifier = identifier
        self.detailsMovieUseCase = detailsMovieUseCase
        self.similarMovieUseCase = similarMovieUseCase
        self.loadingView = loadingView
        self.delegate = delegate
    }
    
    // MARK: - PUBLIC METHODS
    public func fetchDetailMovie() {
        loadingView.start()
        
        let dispatchGroup = DispatchGroup()
        let queue = DispatchQueue.global(qos: .userInitiated)
        
        queue.async { [weak self] in
            if let self = self {
                dispatchGroup.enter()
                
                self.similarMovieUseCase.getAllSimilarMovies(identifier: self.identifier) { [weak self] result in
                    if let self = self {
                        defer {
                            dispatchGroup.leave()
                        }
                        guard case .success(let similarMovies) = result else {
                            dispatchGroup.leave()
                            return
                        }
                        self.similarMovies = similarMovies.results
                    }
                }
                
                dispatchGroup.enter()
                self.detailsMovieUseCase.getDetailsMovie(identifier: self.identifier) { [weak self] result in
                    if let self = self {
                        defer {
                            dispatchGroup.leave()
                        }
                        self.loadingView.stop()
                        switch result {
                        case .success(let detailsMovie):
                            self.detailsMovie = detailsMovie
                        case .failure(let error):
                            self.delegate.presentError(error)
                        }
                    }
                }
                dispatchGroup.wait()
                dispatchGroup.notify(queue: .main) { [weak self] in
                    if let self = self {
                        self.handleSuccess()
                    }
                }
            }
        }
    }
    
    // MARK: - PRIVATE METHODS
    private func handleSuccess() {
        let headerDetailsMovieViewModel = HeaderDetailsMovieViewModel(
            identifier: String(detailsMovie.identifier),
            title: detailsMovie.title,
            genres: detailsMovie.genres.map { $0.name },
            overview: detailsMovie.overview,
            tagline: detailsMovie.tagline,
            releaseDate: detailsMovie.releaseDate,
            voteAverage: detailsMovie.voteAverage,
            backdropPathString: detailsMovie.backdropPath
        )
        
        let detailsMovieVideosResults = detailsMovie.videos.results.filter {
            return $0.site == .youtube ? true : false
        }
        
        let trailersMovieViewModel = detailsMovieVideosResults.map {
            TrailerMovieViewModel(
                trailerID: $0.identifier,
                thumbURL: $0.key.thumbImageURL,
                videoURL: $0.key.trailerVideoURL
            )
        }
        
        let similarMoviesViewModel = similarMovies.map {
            MovieViewModel(
                identifier: String($0.identifier),
                title: $0.title,
                releaseDate: $0.releaseDate,
                voteAverage: $0.voteAverage,
                posterPathString: $0.posterPath
            )
        }
        
        let detailsMovieViewModel = DetailsMovieViewModel(
            headerDetailsMovieViewModel: headerDetailsMovieViewModel,
            trailersMovieViewModel: trailersMovieViewModel,
            similarMoviesViewModel: similarMoviesViewModel
        )
        delegate.presentDetailsMovie(detailsMovieViewModel)
    }
}
