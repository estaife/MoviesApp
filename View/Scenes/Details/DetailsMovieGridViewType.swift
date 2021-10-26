//
//  DetailsMovieGridViewType.swift
//  View
//
//  Created by Estaife Lima on 24/10/21.
//

import UIKit

protocol DetailsMovieViewType: AnyObject {
    var content: UIView { get }
    func updateView(with viewState: DetailsMovieViewState)
}

extension DetailsMovieViewType where Self: UIView {
    var content: UIView { return self }
}
