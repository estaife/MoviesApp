//
//  DetailsMovieViewController.swift
//  View
//
//  Created by Estaife Lima on 24/10/21.
//

import UIKit
import Domain
import Presenter

public protocol DetailsMovieViewControllerDelegate: AlertControllerDelegate { }

public final class DetailsMovieViewController: UIViewController {
    
    // MARK: - Properties
    public var presenter: DetailsMoviePresenter?
    public weak var delegate: DetailsMovieViewControllerDelegate?
    
    private struct Strings {
        static let title = "Details"
    }
    
    // MARK: - Life Cycle
    public override func loadView() {
        super.loadView()
        view = DetailsMovieView()
        title = Strings.title
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

// MARK: - LoadingViewProtocol
extension DetailsMovieViewController: LoadingViewProtocol {
    public var isLoading: Bool {
        (view as? DetailsMovieView)?.isLoading ?? false
    }
    
    public func start() {
        (view as? DetailsMovieView)?.updateView(with: .startLoading)
    }
    
    public func stop() {
        (view as? DetailsMovieView)?.updateView(with: .stopLoading)
    }
}
