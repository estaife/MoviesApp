//
//  PopularMoviesViewController.swift
//  View
//
//  Created by Estaife Lima on 11/10/21.
//

import UIKit
import Domain
import Presenter

public protocol PopularMoviesViewControllerDelegate: AnyObject {
    func openDetail(identifier: String)
}

public final class PopularMoviesViewController: UIViewController {
    
    public var presenter: PopularMoviesPresenter?
    public weak var delegate: PopularMoviesViewControllerDelegate?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.fetchPopularMovies()
    }
}

// MARK: - PopularMoviesPresenterProtocol
extension PopularMoviesViewController: PopularMoviesPresenterProtocol {
    public func presentPopularMovies(_ movies: [MovieViewModel]) {
        print(movies.map({ r in
            r.posterPathUrl
        }))
    }
    
    public func presentError(_ error: DomainError) {
        print(error)
    }
}

// MARK: - LoadingViewProtocol
extension PopularMoviesViewController: LoadingViewProtocol {
    public var isLoading: Bool {
        true
    }
    
    public func start() {
        
    }
    
    public func stop() {
        
    }
}
