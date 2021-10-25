//
//  GridViewDelegate.swift
//  View
//
//  Created by Estaife Lima on 21/10/21.
//

import Foundation

protocol GridViewDelegate: AnyObject {
    func goToDetailMovieScene(identifier: String)
    func makeFetchMoreMovies()
}

extension GridViewDelegate {
    func makeFetchMoreMovies() { }
}
