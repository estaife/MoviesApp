//
//  TrailerMovieViewModel.swift
//  Presenter
//
//  Created by Estaife Lima on 31/10/21.
//

import Foundation

public struct TrailerMovieViewModel {
    
    // MARK: - Public Properties
    public let trailerID: String
    public let thumbURL: URL?
    public let videoURL: URL?
    
    // MARK: - Internal Properties
    let identifier: UUID = UUID()

    // MARK: - Initializer
    public init(trailerID: String, thumbURL: URL?, videoURL: URL?) {
        self.trailerID = trailerID
        self.thumbURL = thumbURL
        self.videoURL = videoURL
    }
}

// MARK: - Equatable
extension TrailerMovieViewModel: Equatable {
    public static func ==(lhs: TrailerMovieViewModel, rhs: TrailerMovieViewModel) -> Bool {
        return lhs.trailerID == rhs.trailerID
    }
}

// MARK: - Hashable
extension TrailerMovieViewModel: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}
