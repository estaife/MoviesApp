//
//  TrailersCollectionViewCellType.swift
//  View
//
//  Created by Estaife Lima on 30/10/21.
//

import Foundation
import Presenter

internal protocol TrailersCollectionViewCellType: AnyObject {
    func updateView(with trailerEntities: [TrailerMovieViewModel])
}
