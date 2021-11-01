//
//  MoviesCollectionGridView.swift
//  View
//
//  Created by Estaife Lima on 21/10/21.
//

import UIKit
import Presenter

final class MoviesCollectionGridView: CustomView {
    
    // MARK: - PUBLIC PROPERTIES
    weak var delegate: GridViewDelegate?
    
    // MARK: - PRIVATE PROPERTIES
    private var moviesViewModel = [MovieViewModel]()
    
    // MARK: - Metrics
    private struct Metrics {
        static let sizeCell: CGSize = .init(width: 200, height: 375)
        static let edgeInsets = UIEdgeInsets(top: 10, left: 24, bottom: 10, right: 24)
        static let spacing: CGFloat = 20
    }
    
    // MARK: - DATASOURCE
    private enum Section {
        case main
    }
    
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, MovieViewModel>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, MovieViewModel>
    
    private var dataSource: DataSource! = nil
    
    // MARK: - UI
    private lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = Metrics.spacing
        layout.minimumInteritemSpacing = Metrics.spacing
        layout.scrollDirection = .vertical
        return layout
    }()
    
    private lazy var moviesCollectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: bounds,
            collectionViewLayout: collectionViewLayout
        )
        collectionView.contentInset = Metrics.edgeInsets
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
    
    // MARK: - INITALIZER
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        setupDataSource()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - VIEW HIERARCHY
    public func subviews() {
        addSubview(moviesCollectionView)
    }
    
    public func constraints() {
        NSLayoutConstraint.activate([
            moviesCollectionView.topAnchor.constraint(equalTo: topAnchor),
            moviesCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            moviesCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            moviesCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    public func style() {
        backgroundColor = .systemBackground
    }
    
    // MARK: - Setup DataSource
    private func setupDataSource() {
        dataSource = DataSource(collectionView: moviesCollectionView) {
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
    
    // MARK: - PUBLIC FUNC
    public func applySnapshot(movies: [MovieViewModel], isAppending: Bool = true) {
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
extension MoviesCollectionGridView: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return Metrics.sizeCell
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
