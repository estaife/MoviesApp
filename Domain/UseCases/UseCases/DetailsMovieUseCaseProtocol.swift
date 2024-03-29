//
//  DetailsMovieUseCaseProtocol.swift
//  Domain
//
//  Created by Estaife Lima on 25/10/21.
//

import Foundation

public protocol DetailsMovieUseCaseProtocol {
    func getDetailsMovie(identifier: String, completion: @escaping (Result<CompleteMovieResponse, DomainError>) -> Void)
}
