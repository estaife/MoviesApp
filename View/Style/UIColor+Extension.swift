//
//  UIColor+Extension.swift
//  View
//
//  Created by Estaife Lima on 21/10/21.
//

import UIKit.UIColor

extension UIColor {
    public class var descriptionColor: UIColor {
        .init(named: "descriptionColor", in: BundleModule.bundle, compatibleWith: nil) ?? .label
    }
}
