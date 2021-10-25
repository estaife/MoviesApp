//
//  DetailsMoviesGridViewType.swift
//  View
//
//  Created by Estaife Lima on 24/10/21.
//

import UIKit

protocol DetailsMoviesViewType: AnyObject {
    var content: UIView { get }
    func updateView(with viewState: DetailsMoviesViewState)
}

extension DetailsMoviesViewType where Self: UIView {
    var content: UIView { return self }
}
