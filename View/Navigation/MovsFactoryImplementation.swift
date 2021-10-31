//
//  MovsFactoryImplementation.swift
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
    
    public func makePopularMoviesViewController() -> UIViewController {
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
    
    public func makeAlertController(alertStyle: AlertControllerStyle, message: String?) -> UIViewController {
        AlertController(alertStyle: alertStyle, message: message)
    }
    
    public func makeDetailsMovieViewController(identifier: String) -> UIViewController {
        let viewController = DetailsMovieViewController()
        let requester = RequesterHTTP()
        let locate = LocateUseCase(locale: Locale.current)
        let useCase = DetailsMovieUseCase(
            requesterHTTP: requester,
            locate: locate
        )
        let presenter = DetailsMoviePresenter(
            identifier: identifier,
            detailsMovieUseCase: useCase,
            loadingView: viewController,
            delegate: viewController
        )
        viewController.presenter = presenter
        return viewController
    }
    
    public func makeEmbedYoutubeVideoViewController(url: URL) -> UIViewController {
        EmbedYoutubeVideoViewController(url: url)
    }
}
