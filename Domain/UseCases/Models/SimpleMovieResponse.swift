//
//  SimpleMovieResponse.swift
//  Domain
//
//  Created by Estaife Lima on 14/09/20.
//

import Foundation

// MARK: - SimpleMovieResponse
public struct SimpleMovieResponse: BaseModel {
    public let posterPath: String?
    public let releaseDate: String
    public let identifier: Int
    public let title: String
    public let voteAverage: Double

    private enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case identifier = "id"
        case title
        case voteAverage = "vote_average"
    }
    
    public init(
        posterPath: String?,
        releaseDate: String,
        identifier: Int,
        title: String,
        voteAverage: Double
    ) {
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.identifier = identifier
        self.title = title
        self.voteAverage = voteAverage
    }
}
