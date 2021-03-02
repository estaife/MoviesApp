//
//  MovieResults.swift
//  Domain
//
//  Created by Estaife Lima on 14/09/20.
//

import Foundation

public struct MovieResults: BaseModel {
    public let page: Int
    public let results: [SimpleMovieResponse]
    public let totalPages: Int
    public let totalResults: Int
    
    private enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
    public init(page: Int, results: [SimpleMovieResponse], totalPages: Int, totalResults: Int) {
        self.page = page
        self.results = results
        self.totalPages = totalPages
        self.totalResults = totalResults
    }
}
