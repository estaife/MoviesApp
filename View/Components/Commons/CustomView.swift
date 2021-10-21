//
//  CustomView.swift
//  View
//
//  Created by Estaife Lima on 21/10/21.
//

import UIKit

public typealias CustomView = UIView & CustomViewProtocol
public typealias CustomViewController = UIViewController & CustomViewProtocol
public typealias CustomCollectionViewCell = UICollectionViewCell & CustomViewProtocol
public typealias CustomCollectionView = UICollectionView & CustomViewProtocol
public typealias CustomCollectionReusableView = UICollectionReusableView & CustomViewProtocol

public protocol CustomViewProtocol {
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
    
    public func style() { }
}
