//
//  DetailsMovieViewModel.swift
//  Presenter
//
//  Created by Estaife Lima on 26/10/21.
//

import Foundation
import UIKit.UIColor
import Core

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
    
    public var releaseYearAttributedString: NSAttributedString {
        attributedStringGeneric(
            description: "Lançamento ",
            contentGenres: String(releaseDate.prefix(4)).dateFormated(format: .medium)
        )
    }
    
    public var genresAttributedString: NSAttributedString {
        var contentGenres = genres.reduce("", { $0 + $1 + ", " })
        contentGenres.removeLast(2)
        return attributedStringGeneric(
            description: "Gêneros ",
            contentGenres: contentGenres
        )
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
    
    private func attributedStringGeneric(
        description: String,
        contentGenres: String
    ) -> NSAttributedString {
        let mutableAttributedString = NSMutableAttributedString()
        let descriptionAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.descriptionColor
        ]
        let contentAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        mutableAttributedString.append(
            .init(string: description,
                  attributes: descriptionAttributes
                 )
        )
        mutableAttributedString.append(
            .init(string: contentGenres,
                  attributes: contentAttributes
                 )
        )
        return mutableAttributedString
    }
}
