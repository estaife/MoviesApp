//
//  ImageHeaderViewState.swift
//  View
//
//  Created by Estaife Lima on 30/10/21.
//

import Foundation
import Presenter

internal enum ImageHeaderViewState {
    case error
    case loading
    case hasData(HeaderDetailsMovieViewModel)
}
