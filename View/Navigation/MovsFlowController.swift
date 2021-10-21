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
    }
    
    // MARK: - PUBLIC API
    public let navigationController: UINavigationController
    
    public func start() {
        let popularMoviesViewController = movsFactory.makePopularMoviesViewController()
        popularMoviesViewController.delegate = self

        navigationController.pushViewController(popularMoviesViewController, animated: false)
    }
}

// MARK: - MovsFlowControllerDelegate
extension MovsFlowController: MovsFlowControllerDelegate { }

// MARK: - PopularMoviesViewControllerDelegate
extension MovsFlowController: PopularMoviesViewControllerDelegate {
    public func openDetail(identifier: String) {
        // TODO: - Implement this
    }
}

// MARK: - AlertControllerDelegate
extension MovsFlowController: AlertControllerDelegate {
    public func presentAlert(with alertStyle: AlertControllerStyle, and message: String?) {
        let alertController = movsFactory.makeAlertController(alertStyle: alertStyle, message: message)
        alertController.modalPresentationStyle = .overCurrentContext
        navigationController.topViewController?.present(alertController, animated: false)
    }
}
