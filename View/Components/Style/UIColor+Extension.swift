//
//  UIColor+Extension.swift
//  View
//
//  Created by Estaife Lima on 21/10/21.
//

import UIKit.UIColor

extension UIColor {
    public class var descriptionColor: UIColor {
        return UIColor(named: "descriptionColor") ?? .label
    }
}
