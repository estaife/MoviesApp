//
//  SimpleMovieResponse.swift
//  Domain
//
//  Created by Estaife Lima on 14/09/20.
//

import Foundation

public struct SimpleMovieResponse: Codable {
    public let posterPath: String?
    public let adult: Bool
    public let overview: String
    public let releaseDate: String
    public let genreIds: [Int]
    public let identifier: Int
    public let originalTitle: String
    public let originalLanguage: String
    public let title: String
    public let backdropPath: String?
    public let popularity: Double
    public let voteCount: Int
    public let video: Bool
    public let voteAverage: Double
    
    var releaseYear: String {
        return String(releaseDate.prefix(4))
    }
    
    private enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case adult
        case overview
        case releaseDate = "release_date"
        case genreIds = "genre_ids"
        case identifier = "id"
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case title
        case backdropPath = "backdrop_path"
        case popularity
        case voteCount = "vote_count"
        case video
        case voteAverage = "vote_average"
    }
}
