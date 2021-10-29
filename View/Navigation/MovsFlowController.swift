//
//  MovsFlowController.swift
//  View
//
//  Created by Estaife Lima on 16/10/21.
//

import UIKit

public protocol MovsFlowControllerDelegate: AnyObject {
    // TODO: - Implement this
}


public final class MovsFlowController {
    
    // MARK: - INTERNAL PROPERTIES
    private let movsFactory: MovsFactory
    
    // MARK: - INITIALIZERS
    public init(navigationController: UINavigationController, movsFactory: MovsFactory) {
        self.navigationController = navigationController
        self.movsFactory = movsFactory
        self.styleNavigationController()
    }
    
    // MARK: - PUBLIC API
    public let navigationController: UINavigationController
    
    public func start() {
        if let popularMoviesViewController = movsFactory.makePopularMoviesViewController() as? PopularMoviesViewController {
            popularMoviesViewController.delegate = self

            navigationController.pushViewController(popularMoviesViewController, animated: false)
        }
    }
    
    private func styleNavigationController() {
        navigationController.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController.navigationBar.shadowImage = nil
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationItem.largeTitleDisplayMode = .automatic
    }
}

// MARK: - MovsFlowControllerDelegate
extension MovsFlowController: MovsFlowControllerDelegate { }

// MARK: - PopularMoviesViewControllerDelegate
extension MovsFlowController: PopularMoviesViewControllerDelegate {
    public func popularMoviesViewControllerOpenDetailMovie(identifier: String) {
        if let detailMoviesViewController = movsFactory.makeDetailsMovieViewController(identifier: identifier) as? DetailsMovieViewController {
            detailMoviesViewController.delegate = self
            
            navigationController.pushViewController(detailMoviesViewController, animated: false)
        }
    }
}

// MARK: - DetailsMoviesViewControllerDelegate
extension MovsFlowController: DetailsMovieViewControllerDelegate { }

// MARK: - AlertControllerDelegate
extension MovsFlowController: AlertControllerDelegate {
    public func presentAlert(with alertStyle: AlertControllerStyle, and message: String?) {
        let alertController = movsFactory.makeAlertController(alertStyle: alertStyle, message: message)
        alertController.modalPresentationStyle = .overCurrentContext
        navigationController.topViewController?.present(alertController, animated: false)
    }
}
