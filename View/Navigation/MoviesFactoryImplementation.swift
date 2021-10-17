//
//  MoviesFactoryImplementation.swift
//  View
//
//  Created by Estaife Lima on 16/10/21.
//

import UIKit
import Presenter
import Data
import Networking

public final class MovsFactoryImplementation: MovsFactory {
    
    // MARK: - Initializer
    public init() { }
    
    // MARK: - MovsFactory
    public func makeMovsFlowController(
        from navigationController: UINavigationController
    ) -> MovsFlowController {
        MovsFlowController(
            navigationController: navigationController,
            movsFactory: self
        )
    }
    
    public func makePopularMoviesViewController() -> PopularMoviesViewController {
        let viewController = PopularMoviesViewController()
        let requester = RequesterHTTP()
        let locate = LocateUseCase(locale: Locale.current)
        let useCase = PopularMoviesUseCase(
            requesterHTTP: requester,
            locate: locate
        )
        let presenter = PopularMoviesPresenter(
            popularMoviesUseCase: useCase,
            loadingView: viewController,
            delegate: viewController
        )
        viewController.presenter = presenter
        return viewController
    }
}
