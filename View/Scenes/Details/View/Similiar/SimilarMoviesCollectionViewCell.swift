//
//  SimilarMoviesCollectionViewCell.swift
//  View
//
//  Created by Estaife Lima on 01/11/21.
//

import UIKit
import Presenter

final class SimilarMoviesCollectionViewCell: CustomCollectionViewCell {
    
    // MARK: - INTERNAL PROPERTIES
    weak var delegate: GridViewDelegate?
    static let identifier = String(describing: SimilarMoviesCollectionViewCell.self)
    
    // MARK: - PRIVATE PROPERTIES
    private var moviesViewModel = [MovieViewModel]()
    
    private var viewState: ViewState = .loading {
        didSet { transition(to: viewState) }
    }
    
    private struct Strings {
        static let title = "Similares"
    }
    
    // MARK: - Metrics
    private struct Metrics {
        static let sizeCell: CGSize = .init(width: 200, height: 375)
        static let edgeInsets = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        static let spacing: CGFloat = 10
        static let sideMargin: CGFloat = 32
    }
    
    // MARK: - DATASOURCE
    private enum Section {
        case main
    }
    
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, MovieViewModel>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, MovieViewModel>
    
    private var dataSource: DataSource! = nil
    
    // MARK: - UI
    private var trailingAnchorConstraintCollectionView = NSLayoutConstraint()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .label
        label.font = .systemFont(ofSize: 25, weight: .semibold)
        label.text = Strings.title
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = Metrics.spacing * 3
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    private lazy var similarMoviesCollectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: bounds,
            collectionViewLayout: collectionViewLayout
        )
        collectionView.contentInset = Metrics.edgeInsets
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.register(
            MovieCollectionViewCell.self,
            forCellWithReuseIdentifier: MovieCollectionViewCell.reuseIdentifier
        )
        return collectionView
    }()
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView(style: .medium)
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.color = .systemGray
        indicatorView.startAnimating()
        return indicatorView
    }()
    
    // MARK: - INITALIZER
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        setupDataSource()
        viewState = .loading
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - VIEW HIERARCHY
    internal func subviews() {
        addSubview(titleLabel)
        addSubview(similarMoviesCollectionView)
        addSubview(activityIndicatorView)
    }
    
    internal func constraints() {
        trailingAnchorConstraintCollectionView = similarMoviesCollectionView.trailingAnchor.constraint(
            equalTo: trailingAnchor
        )
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(
                equalTo: topAnchor,
                constant: Metrics.spacing
            ),
            titleLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: Metrics.sideMargin
            ),
            
            similarMoviesCollectionView.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor
            ),
            similarMoviesCollectionView.leadingAnchor.constraint(
                equalTo: leadingAnchor
            ),
            trailingAnchorConstraintCollectionView,
            similarMoviesCollectionView.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -Metrics.sideMargin
            ),

            activityIndicatorView.centerYAnchor.constraint(
                equalTo: similarMoviesCollectionView.centerYAnchor
            ),
            activityIndicatorView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -Metrics.spacing
            ),
        ])
    }
    
    internal func style() {
        backgroundColor = .systemBackground
    }
    
    // MARK: - Setup DataSource
    private func setupDataSource() {
        dataSource = DataSource(collectionView: similarMoviesCollectionView) {
            (
                collectionView: UICollectionView,
                indexPath: IndexPath,
                movieEntity: MovieViewModel
            ) -> UICollectionViewCell? in
            
            let cellOptional = collectionView.dequeueReusableCell(
                withReuseIdentifier: MovieCollectionViewCell.reuseIdentifier,
                for: indexPath
            ) as? MovieCollectionViewCell
            guard let cell = cellOptional else {
                return UICollectionViewCell()
            }
            cell.updateView(with: movieEntity)
            return cell
        }
    }
    
    // MARK: - PRIVATE FUNC
    private func applySnapshot(movies: [MovieViewModel], isAppending: Bool = true) {
        if isAppending {
            moviesViewModel.append(contentsOf: movies)
        } else {
            moviesViewModel = movies
        }
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(moviesViewModel)
        dataSource.apply(snapshot, animatingDifferences: isAppending)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout & UICollectionViewDelegate
extension SimilarMoviesCollectionViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        Metrics.sizeCell
    }
    
    public func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        if indexPath.row + 1 == moviesViewModel.count {
            delegate?.makeFetchMoreMovies()
        }
    }
    
    public func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let movieIdentifier = moviesViewModel[indexPath.item].identifier
        delegate?.goToDetailMovieScene(identifier: movieIdentifier)
    }
}

// MARK: - PopularMoviesGridViewType
extension SimilarMoviesCollectionViewCell: SimilarMoviesCollectionViewCellType {
    func updateView(with viewState: SimilarMoviesCollectionViewCellViewState) {
        switch viewState {
        case .hasData(let movies):
            self.applySnapshot(movies: movies)
            self.viewState = .hasData
        case .loading:
            self.viewState = .loading
        case .stopLoading:
            self.viewState = .hasData
        }
    }
}

// MARK: - ViewStateProtocol
extension SimilarMoviesCollectionViewCell: ViewStateProtocol {
    internal func transition(to state: ViewState) {
        switch state {
        case .loading:
            activityIndicatorView.startAnimating()
            trailingAnchorConstraintCollectionView.constant = -(activityIndicatorView.bounds.width + Metrics.spacing)
        case .hasData:
            activityIndicatorView.stopAnimating()
            trailingAnchorConstraintCollectionView.constant = 0
        case .error: break
        }
    }
}
