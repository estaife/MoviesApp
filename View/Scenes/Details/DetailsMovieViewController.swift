//
//  DetailsMovieViewController.swift
//  View
//
//  Created by Estaife Lima on 24/10/21.
//

import UIKit
import Domain
import Presenter

internal protocol DetailsMovieViewControllerDelegate: AlertControllerDelegate {
    func detailsMovieViewControllerPrensetVideo(with url: URL)
}

internal final class DetailsMovieViewController: UIViewController {
    
    // MARK: - Properties
    internal var presenter: DetailsMoviePresenter?
    internal weak var delegate: DetailsMovieViewControllerDelegate?

    // MARK: - Life Cycle
    internal override func loadView() {
        super.loadView()
        view = DetailsMovieView(delegate: self)
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
        (view as? DetailsMovieView)?.updateView(with: .loading)
    }
    
    internal func stop() {
        (view as? DetailsMovieView)?.updateView(with: .stopLoading)
    }
}

// MARK: - LoadingViewProtocol
extension DetailsMovieViewController: DetailsMoviePresenterDelegate {
    internal func presentDetailsMovie(_ movie: DetailsMovieViewModel) {
        (view as? DetailsMovieView)?.updateView(with: .hasData(movie))
    }
    
    internal func presentError(_ error: DomainError) {
        (view as? DetailsMovieView)?.updateView(with: .error(error.localizedDescription))
    }
}

// MARK: - TrailersCollectionViewCellDelegate
extension DetailsMovieViewController: TrailersCollectionViewCellDelegate {
    func trailersCollectionViewCellPrensetAlert(with message: String) {
        delegate?.alertControllerPresentAlert(with: .error, and: message)
    }
    
    func trailersCollectionViewCellPrensetVideo(with url: URL) {
        delegate?.detailsMovieViewControllerPrensetVideo(with: url)
    }
}
