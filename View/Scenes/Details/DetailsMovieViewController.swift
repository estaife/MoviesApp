//
//  DetailsMovieViewController.swift
//  View
//
//  Created by Estaife Lima on 24/10/21.
//

import UIKit
import Domain
import Presenter

internal protocol DetailsMovieViewControllerDelegate: AlertControllerDelegate { }

internal final class DetailsMovieViewController: UIViewController {
    
    // MARK: - Properties
    internal var presenter: DetailsMoviePresenter?
    internal weak var delegate: DetailsMovieViewControllerDelegate?
    
    private struct Strings {
        static let title = "Details"
    }
    
    // MARK: - Life Cycle
    internal override func loadView() {
        super.loadView()
        view = DetailsMovieView()
        title = Strings.title
    }
    
    internal override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.fetchDetailMovie()
    }
}

// MARK: - LoadingViewProtocol
extension DetailsMovieViewController: LoadingViewProtocol {
    internal var isLoading: Bool {
        (view as? DetailsMovieView)?.isLoading ?? false
    }
    
    internal func start() {
        (view as? DetailsMovieView)?.updateView(with: .startLoading)
    }
    
    internal func stop() {
        (view as? DetailsMovieView)?.updateView(with: .stopLoading)
    }
}

// MARK: - LoadingViewProtocol
extension DetailsMovieViewController: DetailsMoviePresenterDelegate {
    internal func presentDetailMovie(_ movie: DetailsMovieViewModel) {
        print(movie)
    }
    
    internal func presentError(_ error: DomainError) {
        print(error)
    }
}
