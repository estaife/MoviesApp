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
    
    private let presenter: PopularMoviesPresenter
    public weak var delegate: PopularMoviesViewControllerDelegate?
    
    init(presenter: PopularMoviesPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        self.presenter.delegate = self
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.getPopularMovies(page: "1")
    }
}

extension PopularMoviesViewController: PopularMoviesPresenterProtocol {
    public func presentError(_ error: DomainError) {
        print(error)
    }
    
    public func presentPopularMovies(_ movies: [SimpleMovieResponse]) {
        print(movies)
    }
}
