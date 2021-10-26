//
//  DetailsMoviesGridViewState.swift
//  View
//
//  Created by Estaife Lima on 24/10/21.
//

import Foundation
import Presenter

enum DetailsMoviesViewState {
    case hasData(MovieViewModel)
    case startLoading
    case stopLoading
    case error(String)
}
