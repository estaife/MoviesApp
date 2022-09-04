//
//  PopularMoviesGridView.swift
//  View
//
//  Created by Estaife Lima on 21/10/21.
//

import UIKit

final class PopularMoviesGridView: CustomView {
    
    // MARK: - INTERNAL PROPERTIES
    internal var isLoading: Bool {
        activityIndicatorView.isAnimating
    }
    
    // MARK: - PRIVATE PROPERTIES
    private weak var gridViewPaginationDelegate: GridViewPaginationDelegate?
    
    private var viewState: ViewState = .loading {
        didSet { transition(to: viewState) }
    }
    
    private struct Strings {
        static let informationTitle = "Opss, estamos trabalhando para melhorar"
        static let informationButtonTitle = "Tentar novamente"
    }
    
    private struct Metrics {
        static let spacing: CGFloat = 20
    }
    
    // MARK: - UI
    private var bottomAnchorConstraintCollectionView = NSLayoutConstraint()
    
    private lazy var errorInformationView: InformationView = {
        let view = InformationView(
            title: Strings.informationTitle,
            action: UIAction(
                title: Strings.informationButtonTitle,
                handler: { [unowned self] _ in
                    self.gridViewPaginationDelegate?.makeFetchMoreMovies()
                }
            )
        )
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
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
    internal init(
        gridViewNavigationDelegate: GridViewNavigationDelegate,
        gridViewPaginationDelegate: GridViewPaginationDelegate
    ) {
        super.init(frame: .zero)
        self.moviesCollectionGridView.gridViewNavigationDelegate = gridViewNavigationDelegate
        self.moviesCollectionGridView.gridViewPaginationDelegate = gridViewPaginationDelegate
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - VIEW HIERARCHY
    internal func subviews() {
        addSubview(moviesCollectionGridView)
        addSubview(activityIndicatorView)
        addSubview(errorInformationView)
    }
    
    internal func constraints() {
        bottomAnchorConstraintCollectionView = moviesCollectionGridView.bottomAnchor.constraint(equalTo: bottomAnchor)
        
        NSLayoutConstraint.activate([
            moviesCollectionGridView.topAnchor.constraint(equalTo: topAnchor),
            moviesCollectionGridView.leadingAnchor.constraint(equalTo: leadingAnchor),
            moviesCollectionGridView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomAnchorConstraintCollectionView,
            
            activityIndicatorView.centerXAnchor.constraint(equalTo: moviesCollectionGridView.centerXAnchor),
            activityIndicatorView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Metrics.spacing),
            
            errorInformationView.topAnchor.constraint(equalTo: topAnchor),
            errorInformationView.leadingAnchor.constraint(equalTo: leadingAnchor),
            errorInformationView.trailingAnchor.constraint(equalTo: trailingAnchor),
            errorInformationView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    internal func style() {
        backgroundColor = .systemBackground
    }
}

// MARK: - PopularMoviesGridViewType
extension PopularMoviesGridView: PopularMoviesGridViewType {
    internal func updateView(with viewState: PopularMoviesGridViewState) {
        DispatchQueue.main.async {
            switch viewState {
            case .hasData(let movies):
                self.viewState = .hasData
                self.moviesCollectionGridView.applySnapshot(movies: movies)
            case .startLoading:
                self.viewState = .loading
            case .stopLoading:
                self.viewState = .hasData
            case .error(let error):
                self.viewState = .error
                self.errorInformationView.subtitle = error
                break
            }
        }
    }
}

// MARK: - ViewStateProtocol
extension PopularMoviesGridView: ViewStateProtocol {
    internal func transition(to state: ViewState) {
        switch state {
        case .loading:
            activityIndicatorView.startAnimating()
            bottomAnchorConstraintCollectionView.constant = -(activityIndicatorView.bounds.height + Metrics.spacing)
        case .hasData:
            moviesCollectionGridView.isHidden = false
            errorInformationView.isHidden = true
            activityIndicatorView.stopAnimating()
            bottomAnchorConstraintCollectionView.constant = 0
        case .error:
            moviesCollectionGridView.isHidden = true
            errorInformationView.isHidden = false
        }
    }
}
