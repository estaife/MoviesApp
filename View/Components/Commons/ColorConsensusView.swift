//
//  ColorConsensusView.swift
//  View
//
//  Created by Estaife Lima on 21/10/21.
//

import UIKit.UIColor
import UIKit

typealias Style = ColorConsensusView.StyleStroke

struct ColorConsensusView {
    private struct Metrics {
        static let lowRange = Range(0...33)
        static let mediumRange = Range(34...66)
        static let highRange = Range(67...100)
    }
    
    enum StyleStroke {
        case low
        case medium
        case high
        case none
        
        var color: UIColor {
            switch self {
            case .low:
                return UIColor.systemRed
            case .medium:
                return UIColor.systemYellow
            case .high:
                return UIColor.green
            case .none:
                return UIColor.clear
            }
        }
    }
    
    static func getStyleStroke(value: Int) -> Style {
        if Metrics.lowRange.contains(value) {
            return .low
        } else if Metrics.mediumRange.contains(value) {
            return .medium
        } else if Metrics.highRange.contains(value) {
            return .high
        }
        return .none
    }
}
