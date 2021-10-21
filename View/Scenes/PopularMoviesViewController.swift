//
//  PopularMoviesViewController.swift
//  View
//
//  Created by Estaife Lima on 11/10/21.
//

import UIKit
import Domain
import Presenter

public protocol PopularMoviesViewControllerDelegate: AlertControllerDelegate {
    func openDetail(identifier: String)
}

public final class PopularMoviesViewController: UIViewController {
    
    // MARK: - Properties
    public var presenter: PopularMoviesPresenter?
    public weak var delegate: PopularMoviesViewControllerDelegate?
    
    // MARK: - Life Cycle
    public override func loadView() {
        super.loadView()
        view = PopularMoviesGridView(delegate: self)
        title = "Filmes"
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.fetchPopularMovies()
    }
}

// MARK: - PopularMoviesPresenterProtocol
extension PopularMoviesViewController: PopularMoviesPresenterProtocol {
    public func presentPopularMovies(_ movies: [MovieViewModel]) {
        (view as? PopularMoviesGridView)?.updateView(with: .hasData(movies))
    }
    
    public func presentError(_ error: DomainError) {
        // TODO: - Implement this
    }
}

// MARK: - LoadingViewProtocol
extension PopularMoviesViewController: LoadingViewProtocol {
    public var isLoading: Bool {
        (view as? PopularMoviesGridView)?.isLoading ?? false
    }
    
    public func start() {
        (view as? PopularMoviesGridView)?.updateView(with: .startLoading)
    }
    
    public func stop() {
        (view as? PopularMoviesGridView)?.updateView(with: .stopLoading)
    }
}

// MARK: - GridViewDelegate
extension PopularMoviesViewController: GridViewDelegate {
    func makeFetchMoreMovies() {
        presenter?.fetchPopularMovies()
    }
}
