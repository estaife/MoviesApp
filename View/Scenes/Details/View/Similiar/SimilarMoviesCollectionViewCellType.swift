//
//  SimilarMoviesCollectionViewCellType.swift
//  View
//
//  Created by Estaife Lima on 01/11/21.
//

import UIKit

protocol SimilarMoviesCollectionViewCellType: AnyObject {
    var contentView: UIView { get }
    func updateView(with viewState: SimilarMoviesCollectionViewCellViewState)
}

extension DetailsMovieViewType where Self: UIView {
    var contentView: UIView { return self }
}
