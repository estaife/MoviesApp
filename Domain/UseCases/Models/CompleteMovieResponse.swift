//
//  File.swift
//  Domain
//
//  Created by Estaife Lima on 26/10/21.
//

import Foundation

public struct CompleteMovieResponse: Codable {
    
    let adult: Bool
    let backdropPath: String
    let budget: Int
    let genres: [GenreResponse]
    let homepage: String
    let identifier: Int
    let imdbID: String
    let originalLanguage: String
    let originalTitle, overview: String
    let popularity: Double
    let posterPath: String
    let productionCompanies: [ProductionCompanyResponse]
    let productionCountries: [ProductionCountryResponse]
    let releaseDate: String
    let revenue, runtime: Int
    let spokenLanguages: [SpokenLanguageResponse]
    let status, tagline, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    let videos: VideosResponse
    let images: ImagesResponse
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case identifier = "id"
        case budget, genres, homepage
        case imdbID = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue, runtime
        case spokenLanguages = "spoken_languages"
        case status, tagline, title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case videos, images
    }
}

struct GenreResponse: Codable {
    let identifier: Int
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case name
    }
}

struct ImagesResponse: Codable {
    let backdrops, posters: [BackdropResponse]
}

struct BackdropResponse: Codable {
    let aspectRatio: Double
    let filePath: String
    let height: Int
    let iso6391: String?
    let voteAverage: Double
    let voteCount, width: Int
    
    enum CodingKeys: String, CodingKey {
        case aspectRatio = "aspect_ratio"
        case filePath = "file_path"
        case height
        case iso6391 = "iso_639_1"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case width
    }
}

struct ProductionCompanyResponse: Codable {
    let identifier: Int
    let logoPath: String?
    let name, originCountry: String
    
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}

struct ProductionCountryResponse: Codable {
    let iso31661, name: String
    
    enum CodingKeys: String, CodingKey {
        case iso31661 = "iso_3166_1"
        case name
    }
}

struct SpokenLanguageResponse: Codable {
    let iso6391: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case iso6391 = "iso_639_1"
        case name
    }
}

struct VideosResponse: Codable {
    let results: [ResultResponse]
}

struct ResultResponse: Codable {
    let identifier: String
    let iso6391: String
    let iso31661: String
    let key, name: String
    let site: String
    let size: Int
    let typeVideo: String
    
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case iso6391 = "iso_639_1"
        case iso31661 = "iso_3166_1"
        case key, name, site, size
        case typeVideo = "type"
    }
}
