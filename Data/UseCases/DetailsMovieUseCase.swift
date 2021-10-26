//
//  DetailsMovieUseCase.swift
//  Data
//
//  Created by Estaife Lima on 26/10/21.
//

import Domain

public final class DetailsMovieUseCase {
    private let requesterHTTP: RequesterHTTPProtocol
    private let locate: LocateUseCaseProtocol
    
    public init(requesterHTTP: RequesterHTTPProtocol, locate: LocateUseCaseProtocol) {
        self.requesterHTTP = requesterHTTP
        self.locate = locate
    }
}

// MARK: - DetailsMovieUseCaseProtocol
extension DetailsMovieUseCase: DetailsMovieUseCaseProtocol {
    public func getDetailsMovie(
        identifier: String,
        completion: @escaping (Result<CompleteMovieResponse, DomainError>) -> Void
    ) {
        requesterHTTP.perform(
            request: DetailsMovieRequest(
                identifier: identifier,
                language: locate.getCurrentLocate()
            ),
            type: CompleteMovieResponse.self
        ) { [weak self] result in
            if let _ = self {
                switch result {
                case .success(let movie):
                    completion(.success(movie))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
