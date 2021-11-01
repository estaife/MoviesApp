//
//  HeaderDetailsMovieViewModel.swift
//  Presenter
//
//  Created by Estaife Lima on 31/10/21.
//

import UIKit.UIColor
import Core

public struct HeaderDetailsMovieViewModel {
    
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
            contentGenres: releaseDate.dateFormated(format: .medium)
        )
    }
    
    public var genresAttributedString: NSAttributedString {
        var contentGenres = genres.reduce("", { $0 + $1 + ", " })
        if !contentGenres.isEmpty {
            contentGenres.removeLast(2)
        }
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
    
    // MARK: - Private Funcs
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
