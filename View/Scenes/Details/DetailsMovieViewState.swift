//
//  DetailsMovieGridViewState.swift
//  View
//
//  Created by Estaife Lima on 24/10/21.
//

import Foundation
import Presenter

enum DetailsMovieViewState {
    case hasData(DetailsMovieViewModel)
    case loading
    case stopLoading
    case error(String)
}
