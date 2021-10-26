//
//  DetailsMovieViewModel.swift
//  Presenter
//
//  Created by Estaife Lima on 26/10/21.
//

import Foundation

public struct DetailsMovieViewModel {
    // MARK: - Public Properties
    
    public let identifier: String
    public let title: String
    public let genres: [String]
    public let overview: String
    public let tagline: String
    
    // MARK: - Properties Computed
    public var backdropPathUrl: URL? {
        backdropPathString?.makeUrlImage(.original)
    }
    public var releaseYear: String {
        String(releaseDate.prefix(4))
    }
    public var voteAverage: Int {
        Int(voteAverageDouble * 10)
    }
    
    // MARK: - Private Properties
    private var backdropPathString: String?
    private let releaseDate: String
    private let voteAverageDouble: Double
    
    // MARK: - Initializer
    public init() {
        self.identifier = ""
        self.title = ""
        self.releaseDate = ""
        self.genres = []
        self.overview = ""
        self.tagline = ""
        self.voteAverageDouble = 0
        self.backdropPathString = nil
    }
    
    public init(
        identifier: String,
        title: String,
        genres: [String],
        overview: String,
        tagline: String,
        releaseDate: String,
        voteAverage: Double,
        backdropPathString: String?
    ) {
        self.identifier = identifier
        self.title = title
        self.releaseDate = releaseDate
        self.genres = genres
        self.overview = overview
        self.tagline = tagline
        self.voteAverageDouble = voteAverage
        self.backdropPathString = backdropPathString
    }
}
