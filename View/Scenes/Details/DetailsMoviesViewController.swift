//
//  DetailsMoviesViewController.swift
//  View
//
//  Created by Estaife Lima on 24/10/21.
//

import UIKit
import Domain
import Presenter

public protocol DetailsMoviesViewControllerDelegate: AlertControllerDelegate { }

public final class DetailsMoviesViewController: UIViewController {
    
    // MARK: - Properties
//    public var presenter: DetailsMoviesPresenter?
    public weak var delegate: DetailsMoviesViewControllerDelegate?
    
    private struct Strings {
        static let title = "Details"
    }
    
    // MARK: - Life Cycle
    public override func loadView() {
        super.loadView()
        view = DetailsMoviesView()
        title = Strings.title
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

// MARK: - LoadingViewProtocol
extension DetailsMoviesViewController: LoadingViewProtocol {
    public var isLoading: Bool {
        (view as? DetailsMoviesView)?.isLoading ?? false
    }
    
    public func start() {
        (view as? DetailsMoviesView)?.updateView(with: .startLoading)
    }
    
    public func stop() {
        (view as? DetailsMoviesView)?.updateView(with: .stopLoading)
    }
}
