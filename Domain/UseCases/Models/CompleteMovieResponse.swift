//
//  CompleteMovieResponse.swift
//  Domain
//
//  Created by Estaife Lima on 26/10/21.
//

import Core

// MARK: - CompleteMovieResponse
public struct CompleteMovieResponse: BaseModel {
    public let title: String
    public let identifier: Int
    public let genres: [GenreResponse]
    public let overview: String
    public let posterPath: String
    public let backdropPath: String
    public let releaseDate: String
    public let tagline: String
    public let voteAverage: Double
    public let videos: VideosResponse
    public let images: ImagesResponse
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case identifier = "id"
        case genres
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case tagline
        case voteAverage = "vote_average"
        case videos
        case images
    }
    
    public init(
        title: String,
        identifier: Int,
        genres: [GenreResponse],
        overview: String,
        posterPath: String,
        backdropPath: String,
        releaseDate: String,
        tagline: String,
        voteAverage: Double,
        videos: VideosResponse,
        images: ImagesResponse
    ) {
        self.title = title
        self.identifier = identifier
        self.genres = genres
        self.overview = overview
        self.posterPath = posterPath
        self.backdropPath = backdropPath
        self.releaseDate = releaseDate
        self.tagline = tagline
        self.voteAverage = voteAverage
        self.videos = videos
        self.images = images
    }
    
    // MARK: - GenreResponse
    public struct GenreResponse: Codable {
        public let identifier: Int
        public let name: String
        
        enum CodingKeys: String, CodingKey {
            case identifier = "id"
            case name
        }
        
        public init(
            identifier: Int,
            name: String
        ) {
            self.identifier = identifier
            self.name = name
        }
    }

    // MARK: - ImagesResponse
    public struct ImagesResponse: Codable {
        public let backdrops: [BackdropResponse]
        public let posters: [BackdropResponse]
        
        public init(
            backdrops: [BackdropResponse],
            posters: [BackdropResponse]
        ) {
            self.backdrops = backdrops
            self.posters = posters
        }
    }

    // MARK: - BackdropResponse
    public struct BackdropResponse: Codable {
        public let aspectRatio: Double
        public let filePath: String
        public let iso6391: String?
        public let voteAverage: Double
        public let voteCount: Int
        public let height: Int
        public let width: Int
        
        enum CodingKeys: String, CodingKey {
            case aspectRatio = "aspect_ratio"
            case filePath = "file_path"
            case iso6391 = "iso_639_1"
            case voteAverage = "vote_average"
            case voteCount = "vote_count"
            case height
            case width
        }
        
        public init(
            aspectRatio: Double,
            filePath: String,
            iso6391: String?,
            voteAverage: Double,
            voteCount: Int,
            height: Int,
            width: Int
        ) {
            self.aspectRatio = aspectRatio
            self.filePath = filePath
            self.iso6391 = iso6391
            self.voteAverage = voteAverage
            self.voteCount = voteCount
            self.height = height
            self.width = width
        }
    }

    // MARK: - VideosResponse
    public struct VideosResponse: Codable {
        public let results: [ResultResponse]
        
        public init(
            results: [ResultResponse]
        ) {
            self.results = results
        }
    }

    // MARK: - ResultResponse
    public struct ResultResponse: Codable {
        public let identifier: String
        public let iso6391: String
        public let iso31661: String
        public let key, name: String
        public let site: String
        public let size: Int
        public let typeVideo: String
        
        enum CodingKeys: String, CodingKey {
            case identifier = "id"
            case iso6391 = "iso_639_1"
            case iso31661 = "iso_3166_1"
            case key, name, site, size
            case typeVideo = "type"
        }
    }
}

extension CompleteMovieResponse {
    public static func == (lhs: CompleteMovieResponse, rhs: CompleteMovieResponse) -> Bool {
        lhs.identifier == rhs.identifier
    }
}
