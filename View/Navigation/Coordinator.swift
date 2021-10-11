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
        let alamofireAdapter = AlamofireAdapter()
        let popularMoviesUseCase = PopularMoviesUseCase(httpGetClient: alamofireAdapter, url: URL(string: "https://api.themoviedb.org/3/movie/popular")!) // TODO: - Fixing url mocked
        let presenter = PopularMoviesPresenter(popularMoviesUseCase: popularMoviesUseCase)
        let popularMoviesViewController = PopularMoviesViewController(presenter: presenter)
        navigationController.pushViewController(popularMoviesViewController, animated: true)
    }
}
