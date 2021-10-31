//
//  TrailersCollectionViewCellDelegate.swift
//  View
//
//  Created by Estaife Lima on 30/10/21.
//

import Foundation

public protocol TrailersCollectionViewCellDelegate: AnyObject {
    func trailersCollectionViewCellPrensetVideo(with url: URL)
    func trailersCollectionViewCellPrensetAlert(with message: String)
}
