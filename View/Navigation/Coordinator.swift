//
//  Coordinator.swift
//  View
//
//  Created by Estaife Lima on 11/10/21.
//

import UIKit
import Presenter
import Data
import Networking

// TODO: - Fixing code Coordinator
public protocol BaseCoordinator {
    init(navigationController: UINavigationController)
    func start()
}

public final class Coordinator: BaseCoordinator {
    
    private let navigationController: UINavigationController
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
        let requesterHTTP = RequesterHTTP()
        let popularMoviesUseCase = PopularMoviesUseCase(requesterHTTP: requesterHTTP)
        let presenter = PopularMoviesPresenter(popularMoviesUseCase: popularMoviesUseCase)
        let popularMoviesViewController = PopularMoviesViewController(presenter: presenter)
        navigationController.pushViewController(popularMoviesViewController, animated: true)
    }
}
