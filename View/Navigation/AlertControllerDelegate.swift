//
//  AlertControllerDelegate.swift
//  View
//
//  Created by Estaife Lima on 21/10/21.
//

import Foundation

public protocol AlertControllerDelegate: AnyObject {
    func alertControllerPresentAlert(with alertStyle: AlertControllerStyle, and message: String?)
}
