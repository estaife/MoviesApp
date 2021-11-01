//
//  DetailsMovieView.swift
//  View
//
//  Created by Estaife Lima on 30/10/21.
//

import UIKit
import Presenter

final internal class DetailsMovieView: CustomView {
    
    // MARK: - INTERNAL PROPERTIES
    internal var isLoading: Bool {
        activityIndicatorView.isAnimating
    }
    
    internal weak var trailersCollectionViewCellDelegate: TrailersCollectionViewCellDelegate?
    internal weak var gridViewDelegate: GridViewDelegate?
    
    private var similarMovieViewModel: [MovieViewModel]?
    
    // MARK: - PRIVATE PROPERTIES
    private var viewState: ViewState = .loading {
        didSet { transition(to: viewState) }
    }
    
    private struct Metrics {
        static var trailerSizeCell: CGSize {
            let width = UIScreen.main.bounds.width
            return .init(width: width, height: 280)
        }
        static var movieSizeCell: CGSize {
            let width = UIScreen.main.bounds.width
            return .init(width: width, height: 475)
        }
        static let numberOfItemsInSection = 2
    }
    
    // MARK: - UI
    private var imageHeaderView: ImageHeaderView? {
        didSet {
            if viewState == .loading {
                imageHeaderView?.updateView(with: .loading)
            }
        }
    }
    
    private var trailersCollectionViewCell: TrailersCollectionViewCell? {
        didSet {
            trailersCollectionViewCell?.delegate = trailersCollectionViewCellDelegate
        }
    }
    
    private var similarMoviesCollectionViewCell: SimilarMoviesCollectionViewCell? {
        didSet {
            similarMoviesCollectionViewCell?.delegate = gridViewDelegate
        }
    }
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView(style: .large)
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.color = .systemGray
        indicatorView.backgroundColor = .clear
        return indicatorView
    }()
    
    private lazy var collectionViewContent: UICollectionView = {
        let layout = DetailsMovieLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.backgroundColor = .systemBackground
        collectionView.register(
            ImageHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: ImageHeaderView.identifier
        )
        collectionView.register(
            TrailersCollectionViewCell.self,
            forCellWithReuseIdentifier: TrailersCollectionViewCell.identifier
        )
        collectionView.register(
            SimilarMoviesCollectionViewCell.self,
            forCellWithReuseIdentifier: SimilarMoviesCollectionViewCell.identifier
        )
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    // MARK: - INITALIZER
    internal init(
        trailersCollectionViewCellDelegate: TrailersCollectionViewCellDelegate,
        gridViewDelegate: GridViewDelegate
    ) {
        super.init(frame: .zero)
        self.trailersCollectionViewCellDelegate = trailersCollectionViewCellDelegate
        self.gridViewDelegate = gridViewDelegate
        self.commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - VIEW HIERARCHY
    internal func subviews() {
        addSubview(collectionViewContent)
        addSubview(activityIndicatorView)
    }
    
    internal func constraints() {
        NSLayoutConstraint.activate([
            collectionViewContent.topAnchor.constraint(equalTo: topAnchor),
            collectionViewContent.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionViewContent.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionViewContent.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            activityIndicatorView.topAnchor.constraint(equalTo: topAnchor),
            activityIndicatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            activityIndicatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            activityIndicatorView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    internal func style() {
        backgroundColor = .white
    }
    
    // MARK: - PRIVATE FUNC
    private func showAlertError(message: String) {
        trailersCollectionViewCellDelegate?.trailersCollectionViewCellPrensetAlert(with: message)
    }
}

// MARK: - DetailsMovieViewType
extension DetailsMovieView: DetailsMovieViewType {
    internal func updateViewOrientation() {
        collectionViewContent.collectionViewLayout.invalidateLayout()
    }
    
    internal func updateView(with viewState: DetailsMovieViewState) {
        DispatchQueue.main.async {
            switch viewState {
            case .hasData(let viewEntity):
                self.viewState = .hasData
                self.imageHeaderView?.updateView(
                    with: .hasData(viewEntity.headerDetailsMovieViewModel)
                )
                self.trailersCollectionViewCell?.updateView(
                    with: viewEntity.trailersMovieViewModel
                )
                self.similarMovieViewModel = viewEntity.similarMoviesViewModel
            case .loading:
                self.viewState = .loading
            case .stopLoading:
                self.viewState = .hasData
            case .error(let message):
                self.viewState = .error
                self.showAlertError(message: message)
                self.imageHeaderView?.updateView(with: .error)
            }
        }
    }
}

// MARK: - UICollectionViewDelegate && UICollectionViewDelegateFlowLayout
extension DetailsMovieView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    internal func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        imageHeaderView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: ImageHeaderView.identifier,
            for: indexPath
        ) as? ImageHeaderView
        guard let supplementaryView = imageHeaderView else {
            return .init()
        }
        return supplementaryView
    }
    
    internal func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        switch indexPath.row {
        case 0:
            return Metrics.trailerSizeCell
        case 1:
            return Metrics.movieSizeCell
        default: return .zero
        }
    }
}

// MARK: - UICollectionViewDataSource
extension DetailsMovieView: UICollectionViewDataSource {
    
    internal func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        Metrics.numberOfItemsInSection
    }
    
    internal func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TrailersCollectionViewCell.identifier,
                for: indexPath
            ) as? TrailersCollectionViewCell else {
                return .init()
            }
            trailersCollectionViewCell = cell
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: SimilarMoviesCollectionViewCell.identifier,
                for: indexPath
            ) as? SimilarMoviesCollectionViewCell else {
                return .init()
            }
            cell.updateView(with: .hasData(similarMovieViewModel ?? []))
            return cell
        default:
            return .init()
        }
    }
}

// MARK: - ViewStateProtocol
extension DetailsMovieView: ViewStateProtocol {
    internal func transition(to state: ViewState) {
        switch state {
        case .loading:
            self.collectionViewContent.isScrollEnabled = false
            self.activityIndicatorView.startAnimating()
        case .hasData:
            self.collectionViewContent.isScrollEnabled = true
            self.activityIndicatorView.stopAnimating()
        case .error:
            self.activityIndicatorView.stopAnimating()
        }
    }
}
