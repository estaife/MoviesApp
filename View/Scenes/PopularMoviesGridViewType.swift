//
//  PopularMoviesGridViewType.swift
//  View
//
//  Created by Estaife Lima on 21/10/21.
//

import UIKit

protocol PopularMoviesGridViewType: AnyObject {
    var content: UIView { get }
    func updateView(with viewState: PopularMoviesGridViewState)
}

extension PopularMoviesGridViewType where Self: UIView {
    var content: UIView { return self }
}
