//
//  PopularMoviesGridView.swift
//  View
//
//  Created by Estaife Lima on 21/10/21.
//

import UIKit

final class PopularMoviesGridView: CustomView {
    
    // MARK: - PUBLIC PROPERTIES
    public var isLoading: Bool {
        activityIndicatorView.isAnimating
    }
    
    // MARK: - PRIVATE PROPERTIES
    private var viewState: ViewState = .loading {
        didSet { transition(to: viewState) }
    }
    
    private struct Metrics {
        static let spacing: CGFloat = 20
    }
    
    // MARK: - UI
    private var bottomAnchorConstraintCollectionView = NSLayoutConstraint()

    private lazy var moviesCollectionGridView: MoviesCollectionGridView = {
        let view = MoviesCollectionGridView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView(style: .medium)
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.color = .systemGray
        indicatorView.startAnimating()
        return indicatorView
    }()
    
    // MARK: - INITALIZER
    public init(delegate: GridViewDelegate) {
        super.init(frame: .zero)
        self.moviesCollectionGridView.delegate = delegate
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - VIEW HIERARCHY
    public func subviews() {
        addSubview(moviesCollectionGridView)
        addSubview(activityIndicatorView)
    }
    
    public func constraints() {
        bottomAnchorConstraintCollectionView = moviesCollectionGridView.bottomAnchor.constraint(equalTo: bottomAnchor)
        
        NSLayoutConstraint.activate([
            moviesCollectionGridView.topAnchor.constraint(equalTo: topAnchor),
            moviesCollectionGridView.leadingAnchor.constraint(equalTo: leadingAnchor),
            moviesCollectionGridView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomAnchorConstraintCollectionView,
            
            activityIndicatorView.centerXAnchor.constraint(equalTo: moviesCollectionGridView.centerXAnchor),
            activityIndicatorView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Metrics.spacing)
        ])
    }
    
    public func style() {
        backgroundColor = .systemBackground
    }
}

// MARK: - PopularMoviesGridViewType
extension PopularMoviesGridView: PopularMoviesGridViewType {
    public func updateView(with viewState: PopularMoviesGridViewState) {
        DispatchQueue.main.async {
            switch viewState {
            case .hasData(let movies):
                self.viewState = .hasData
                self.moviesCollectionGridView.applySnapshot(movies: movies)
            case .startLoading:
                self.viewState = .loading
            case .stopLoading:
                self.viewState = .hasData
            case .error(_):
                // TODO: - Implement this
                break
            }
        }
    }
}

// MARK: - ViewStateProtocol
extension PopularMoviesGridView: ViewStateProtocol {
    public func transition(to state: ViewState) {
        switch state {
        case .loading:
            activityIndicatorView.startAnimating()
            bottomAnchorConstraintCollectionView.constant = -(activityIndicatorView.bounds.height + Metrics.spacing)
        case .hasData:
            activityIndicatorView.stopAnimating()
            bottomAnchorConstraintCollectionView.constant = 0
        default: break
        }
    }
}
