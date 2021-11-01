//
//  SimilarMoviesCollectionViewCellViewState.swift
//  View
//
//  Created by Estaife Lima on 01/11/21.
//

import Presenter

enum SimilarMoviesCollectionViewCellViewState {
    case hasData([MovieViewModel])
    case loading
    case stopLoading
}
