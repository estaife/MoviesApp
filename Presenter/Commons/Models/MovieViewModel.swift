//
//  PopularMoviesViewModel.swift
//  Presenter
//
//  Created by Estaife Lima on 20/10/21.
//

import Foundation
import Data

public struct MovieViewModel {
    
    // MARK: - Public Properties
    public let identifier: String
    public let title: String
    
    // MARK: - Properties Computed
    public var posterPathUrl: URL? {
        posterPathString?.makeUrlImage(.w500)
    }
    public var releaseYear: String {
        String(releaseDate.prefix(4))
    }
    public var voteAverage: Int {
        Int(voteAverageDouble * 10)
    }
    
    // MARK: - Private Properties
    private let internalIdentifier: UUID = UUID()
    private var posterPathString: String?
    private let releaseDate: String
    private let voteAverageDouble: Double
    
    // MARK: - Initializer
    public init() {
        self.identifier = ""
        self.title = ""
        self.releaseDate = ""
        self.voteAverageDouble = -1
        self.posterPathString = nil
    }
    
    public init(
        identifier: String,
        title: String,
        releaseDate: String,
        voteAverage: Double,
        posterPathString: String?
    ) {
        self.identifier = identifier
        self.title = title
        self.releaseDate = releaseDate
        self.voteAverageDouble = voteAverage
        self.posterPathString = posterPathString
    }
}

// MARK: - Equatable
extension MovieViewModel: Equatable {
    public static func ==(
        lhs: MovieViewModel,
        rhs: MovieViewModel
    ) -> Bool {
        return lhs.internalIdentifier == rhs.internalIdentifier
    }
}

// MARK: - Hashable
extension MovieViewModel: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}
