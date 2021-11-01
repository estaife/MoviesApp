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
    
    // MARK: - UI
    private lazy var contentView: PopularMoviesGridViewType = {
        let conteView = PopularMoviesGridView(
            delegate: self
        )
        return conteView
    }()
    
    // MARK: - Life Cycle
    internal override func loadView() {
        super.loadView()
        view = contentView.content
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
        contentView.updateView(with: .hasData(movies))
    }
    
    internal func presentError(_ error: DomainError) {
        contentView.updateView(with: .error(error.localizedDescription))
    }
}

// MARK: - LoadingViewProtocol
extension PopularMoviesViewController: LoadingViewProtocol {
    internal var isLoading: Bool {
        (contentView.content as? PopularMoviesGridView)?.isLoading ?? false
    }
    
    internal func start() {
        contentView.updateView(with: .startLoading)
    }
    
    internal func stop() {
        contentView.updateView(with: .stopLoading)
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
