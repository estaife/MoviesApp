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
    
    // MARK: - UI
    private lazy var contentView: DetailsMovieViewType = {
        let conteView = DetailsMovieView(
            trailersCollectionViewCellDelegate: self,
            gridViewNavigationDelegate: self,
            gridViewPaginationDelegate: self
        )
        return conteView
    }()

    // MARK: - Life Cycle
    internal override func loadView() {
        super.loadView()
        view = contentView.content
    }
    
    internal override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.fetchDetailMovie()
    }
}

// MARK: - LoadingViewProtocol
extension DetailsMovieViewController: LoadingViewProtocol {
    internal var isLoading: Bool {
        (contentView.content as? DetailsMovieView)?.isLoading ?? false
    }
    
    internal func start() {
        contentView.updateView(with: .loading)
    }
    
    internal func stop() {
        contentView.updateView(with: .stopLoading)
    }
}

// MARK: - LoadingViewProtocol
extension DetailsMovieViewController: DetailsMoviePresenterDelegate {
    internal func presentDetailsMovie(_ movie: DetailsMovieViewModel) {
        contentView.updateView(with: .hasData(movie))
    }
    
    internal func presentError(_ error: DomainError) {
        contentView.updateView(with: .error(error.localizedDescription))
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

// MARK: - GridViewDelegate
extension DetailsMovieViewController: GridViewDelegate {
    func makeFetchMoreMovies() {
        
    }
    
    func goToDetailMovieScene(identifier: String) {
        
    }
}
