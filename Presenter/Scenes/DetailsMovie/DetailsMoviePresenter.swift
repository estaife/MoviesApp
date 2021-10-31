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
    private let loadingView: LoadingViewProtocol
    private let delegate: DetailsMoviePresenterDelegate
    
    // MARK: - Init
    public init(
        identifier: String,
        detailsMovieUseCase: DetailsMovieUseCaseProtocol,
        loadingView: LoadingViewProtocol,
        delegate: DetailsMoviePresenterDelegate
    ) {
        self.identifier = identifier
        self.detailsMovieUseCase = detailsMovieUseCase
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
                case .success(let detailsMovie):
                    self.handleSuccess(detailsMovie)
                case .failure(let error):
                    self.delegate.presentError(error)
                }
            }
        }
    }
    
    // MARK: - PRIVATE METHODS
    private func handleSuccess(_ completeMovieResponse: CompleteMovieResponse) {
        let headerDetailsMovieViewModel = HeaderDetailsMovieViewModel(
            identifier: String(completeMovieResponse.identifier),
            title: completeMovieResponse.title,
            genres: completeMovieResponse.genres.map { $0.name },
            overview: completeMovieResponse.overview,
            tagline: completeMovieResponse.tagline,
            releaseDate: completeMovieResponse.releaseDate,
            voteAverage: completeMovieResponse.voteAverage,
            backdropPathString: completeMovieResponse.backdropPath
        )
    
        let completeMovieResponseVideosResults = completeMovieResponse.videos.results.filter {
            return $0.site == .youtube ? true : false
        }
        
        let trailersMovieViewModel = completeMovieResponseVideosResults.map {
            TrailerMovieViewModel(
                trailerID: $0.identifier,
                thumbURL: $0.key.thumbImageURL,
                videoURL: $0.key.trailerVideoURL
            )
        }
        
        let detailsMovieViewModel = DetailsMovieViewModel(
            headerDetailsMovieViewModel: headerDetailsMovieViewModel,
            trailersMovieViewModel: trailersMovieViewModel,
            similarMoviesViewModel: []
        )
        delegate.presentDetailsMovie(detailsMovieViewModel)
    }
}
