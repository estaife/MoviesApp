//
//  PopularMoviesViewController.swift
//  View
//
//  Created by Estaife Lima on 11/10/21.
//

import UIKit
import Domain
import Presenter

internal protocol PopularMoviesViewControllerDelegate: AlertControllerDelegate {
    func popularMoviesViewControllerOpenDetailMovie(identifier: String)
}

internal final class PopularMoviesViewController: UIViewController {
    
    // MARK: - Properties
    internal var presenter: PopularMoviesPresenter?
    internal weak var delegate: PopularMoviesViewControllerDelegate?
    
    private struct Strings {
        static let title = "Filmes"
    }
    
    // MARK: - Life Cycle
    internal override func loadView() {
        super.loadView()
        view = PopularMoviesGridView(delegate: self)
        title = Strings.title
    }
    
    internal override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.fetchPopularMovies()
    }
}

// MARK: - PopularMoviesPresenterProtocol
extension PopularMoviesViewController: PopularMoviesPresenterDelegate {
    internal func presentPopularMovies(_ movies: [MovieViewModel]) {
        (view as? PopularMoviesGridView)?.updateView(with: .hasData(movies))
    }
    
    internal func presentError(_ error: DomainError) {
        (view as? PopularMoviesGridView)?.updateView(with: .error(error.localizedDescription))
    }
}

// MARK: - LoadingViewProtocol
extension PopularMoviesViewController: LoadingViewProtocol {
    internal var isLoading: Bool {
        (view as? PopularMoviesGridView)?.isLoading ?? false
    }
    
    internal func start() {
        (view as? PopularMoviesGridView)?.updateView(with: .startLoading)
    }
    
    internal func stop() {
        (view as? PopularMoviesGridView)?.updateView(with: .stopLoading)
    }
}

// MARK: - GridViewDelegate
extension PopularMoviesViewController: GridViewDelegate {
    func goToDetailMovieScene(identifier: String) {
        delegate?.popularMoviesViewControllerOpenDetailMovie(identifier: identifier)
    }
    
    func makeFetchMoreMovies() {
        presenter?.fetchPopularMovies()
    }
}
