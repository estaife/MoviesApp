//
//  PopularMoviesViewController.swift
//  View
//
//  Created by Estaife Lima on 11/10/21.
//

import UIKit
import Domain
import Presenter

class PopularMoviesViewController: UIViewController {
    
    private let presenter: PopularMoviesPresenter
    
    init(presenter: PopularMoviesPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        self.presenter.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.getPopularMovies(page: "1")
    }
}

extension PopularMoviesViewController: PopularMoviesPresenterProtocol {
    func presentError(_ error: DomainError) {
        print(error)
    }
    
    func presentPopularMovies(_ movies: [SimpleMovieResponse]) {
        print(movies)
    }
}

