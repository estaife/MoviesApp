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
    func presentMoreSimilarMovies(_ movies: [MovieViewModel])
    func presentError(_ error: DomainError)
}

final public class DetailsMoviePresenter {
    
    // MARK: - Properties
    private let identifier: String
    private let detailsMovieUseCase: DetailsMovieUseCaseProtocol
    private let similarMovieUseCase: SimilarMoviesUseCaseProtocol
    private let loadingView: LoadingViewProtocol
    private let delegate: DetailsMoviePresenterDelegate
    
    // MARK: - Properties Controller
    private var page: Int = 1
    private var totalPages: Int = 1
    
    // MARK: - Properties Build Final object
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
                        self.totalPages = similarMovies.totalPages
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
    
    public func fetchSimilarMoviesMovies() {
        loadingView.start()
        makePageIncrement()
        let rangeMakeFetch = Range(2...totalPages)
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
        self.similarMovieUseCase.getAllSimilarMovies(identifier: self.identifier) { [weak self] result in
            if let self = self {
                guard case .success(let similarMoviesResponse) = result else {
                    self.delegate.presentMoreSimilarMovies([])
                    return
                }
                self.totalPages = similarMoviesResponse.totalPages
                let similarMovies = similarMoviesResponse.results.map {
                    MovieViewModel(
                        identifier: String($0.identifier),
                        title: $0.title,
                        releaseDate: $0.releaseDate,
                        voteAverage: $0.voteAverage,
                        posterPathString: $0.posterPath
                    )
                }
                self.delegate.presentMoreSimilarMovies(similarMovies)
            }
        }
    }
    
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
