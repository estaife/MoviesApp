//
//  PopularMoviesGridViewState.swift
//  View
//
//  Created by Estaife Lima on 21/10/21.
//

import Foundation
import Presenter

enum PopularMoviesGridViewState {
    case hasData([MovieViewModel])
    case startLoading
    case stopLoading
    case error(String)
}
