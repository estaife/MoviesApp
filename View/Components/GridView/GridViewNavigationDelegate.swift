//
//  GridViewNavigationDelegate.swift
//  View
//
//  Created by Estaife Lima on 21/10/21.
//

import Foundation
 
typealias GridViewDelegate = GridViewPaginationDelegate & GridViewNavigationDelegate

protocol GridViewNavigationDelegate: AnyObject {
    func goToDetailMovieScene(identifier: String)
}
