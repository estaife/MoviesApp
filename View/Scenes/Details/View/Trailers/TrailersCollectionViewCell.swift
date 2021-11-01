//
//  TrailersCollectionViewCell.swift
//  View
//
//  Created by Estaife Lima on 30/10/21.
//

import UIKit
import Presenter

final internal class TrailersCollectionViewCell: CustomCollectionViewCell {
    
    // MARK: - INTERNAL PROPERTIES
    weak var delegate: TrailersCollectionViewCellDelegate?
    static let identifier = String(describing: TrailersCollectionViewCell.self)
    
    // MARK: - PRIVATE PROPERTIES
    private var trailerEntities = [TrailerMovieViewModel]()
    
    private struct Metrics {
        static let sizeCell: CGSize = .init(width: 300, height: 190)
        static let spacing: CGFloat = 10
        static let sideMargin: CGFloat = 32
        static let edgeInsets = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
    }
    
    private struct Strings {
        static let title = "Trailers"
    }
    
    // MARK: - UI
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
    
    private lazy var trailersCollectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: bounds,
            collectionViewLayout: collectionViewLayout
        )
        collectionView.contentInset = Metrics.edgeInsets
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.register(
            ThumbImageCollectionViewCell.self,
            forCellWithReuseIdentifier: ThumbImageCollectionViewCell.reuseIdentifier
        )
        return collectionView
    }()
    
    // MARK: - INITALIZER
    internal override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        setupDataSource()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - VIEW HIERARCHY
    internal func subviews() {
        addSubview(titleLabel)
        addSubview(trailersCollectionView)
    }
    
    internal func constraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(
                equalTo: topAnchor,
                constant: Metrics.spacing
            ),
            titleLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: Metrics.sideMargin
            ),
            
            trailersCollectionView.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor
            ),
            trailersCollectionView.leadingAnchor.constraint(
                equalTo: leadingAnchor
            ),
            trailersCollectionView.trailingAnchor.constraint(
                equalTo: trailingAnchor
            ),
            trailersCollectionView.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -Metrics.sideMargin
            )
        ])
    }
    
    internal func style() {
        backgroundColor = .systemBackground
    }
    
    // MARK: - DATASOURCE
    private enum Section {
        case main
    }
    
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, TrailerMovieViewModel>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, TrailerMovieViewModel>
    
    private var dataSource: DataSource! = nil
    
    private func setupDataSource() {
        dataSource = DataSource(collectionView: trailersCollectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, trailerEntity: TrailerMovieViewModel) -> UICollectionViewCell? in
            let cellOptional = collectionView.dequeueReusableCell(
                withReuseIdentifier: ThumbImageCollectionViewCell.reuseIdentifier,
                for: indexPath
            ) as? ThumbImageCollectionViewCell
            guard let cell = cellOptional else {
                return .init()
            }
            cell.updateView(with: trailerEntity.thumbURL)
            return cell
        }
    }
    
    // MARK: - PRIVATE FUNC
    private func applySnapshot(_ trailerEntities: [TrailerMovieViewModel]) {
        self.trailerEntities = trailerEntities
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(self.trailerEntities)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

// MARK: - TrailersCollectionViewCellType
extension TrailersCollectionViewCell: TrailersCollectionViewCellType {
    internal func updateView(with trailerEntities: [TrailerMovieViewModel]) {
        DispatchQueue.main.async {
            self.applySnapshot(trailerEntities)
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout && UICollectionViewDelegate
extension TrailersCollectionViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    internal func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        Metrics.sizeCell
    }
    
    internal func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        if let url = trailerEntities[indexPath.item].videoURL {
            delegate?.trailersCollectionViewCellPrensetVideo(with: url)
        }
    }
}
