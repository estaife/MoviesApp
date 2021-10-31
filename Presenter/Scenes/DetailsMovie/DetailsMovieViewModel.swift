//
//  DetailsMovieViewModel.swift
//  Presenter
//
//  Created by Estaife Lima on 26/10/21.
//

import Foundation

public struct DetailsMovieViewModel {
    public let headerDetailsMovieViewModel: HeaderDetailsMovieViewModel
    public let trailersMovieViewModel: [TrailerMovieViewModel]
    public let similarMoviesViewModel: [MovieViewModel] // TODO: - Added layer of service
    
    public init(
        headerDetailsMovieViewModel: HeaderDetailsMovieViewModel,
        trailersMovieViewModel: [TrailerMovieViewModel],
        similarMoviesViewModel: [MovieViewModel]
    ) {
        self.headerDetailsMovieViewModel = headerDetailsMovieViewModel
        self.trailersMovieViewModel = trailersMovieViewModel
        self.similarMoviesViewModel = similarMoviesViewModel
    }
}
