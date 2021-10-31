//
//  DetailsMovieLayout.swift
//  View
//
//  Created by Estaife Lima on 30/10/21.
//

import UIKit

internal class DetailsMovieLayout: UICollectionViewFlowLayout {
    
    // MARK: - Metrics
    private struct Metrics {
        static var sizeImageBanner: CGSize {
            let width = UIScreen.main.bounds.width
            return .init(width: width, height: width * 0.6)
        }
        
        static var sizeCell: CGSize {
            let width = UIScreen.main.bounds.width
            return .init(width: width, height: 100)
        }
    }
    
    // MARK: - Layout
    internal override func prepare() {
        scrollDirection = .vertical
        minimumLineSpacing = 10
        minimumInteritemSpacing = 10
        headerReferenceSize = Metrics.sizeImageBanner
        itemSize = Metrics.sizeCell
        
        super.prepare()
    }
    
    override internal func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttributes = super.layoutAttributesForElements(in: rect)
        layoutAttributes?.forEach({ (attributes) in
            if attributes.representedElementKind == UICollectionView.elementKindSectionHeader && attributes.indexPath.section == 0 {
                guard let collectionView = collectionView else { return }
                let contentOffsetY = collectionView.contentOffset.y
                let width = collectionView.frame.width
                let height = attributes.frame.height - contentOffsetY
                attributes.frame = CGRect(x: 0, y: contentOffsetY, width: width, height: height)
            }
        })
        return layoutAttributes
    }
    
    override internal func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
