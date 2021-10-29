//
//  CustomView.swift
//  View
//
//  Created by Estaife Lima on 21/10/21.
//

import UIKit

internal typealias CustomView = UIView & CustomViewProtocol
internal typealias CustomViewController = UIViewController & CustomViewProtocol
internal typealias CustomCollectionViewCell = UICollectionViewCell & CustomViewProtocol
internal typealias CustomCollectionView = UICollectionView & CustomViewProtocol
internal typealias CustomCollectionReusableView = UICollectionReusableView & CustomViewProtocol

internal protocol CustomViewProtocol {
    func subviews()
    func constraints()
    func style()
}

extension CustomViewProtocol {
    ///Don't override this method
    func commonInit() {
        subviews()
        constraints()
        style()
    }
    
    internal func style() { }
}
