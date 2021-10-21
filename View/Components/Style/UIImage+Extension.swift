//
//  UIImage+Extension.swift
//  View
//
//  Created by Estaife Lima on 21/10/21.
//

import UIKit.UIImage

extension UIImage {
    static let mediumConfiguration = UIImage.SymbolConfiguration(weight: .medium)
    static let lightConfiguration = UIImage.SymbolConfiguration(weight: .light)
    
    public class var heart: UIImage? {
        return UIImage(systemName: "suit.heart", withConfiguration: UIImage.mediumConfiguration)
    }
    
    public class var heartFill: UIImage? {
        return UIImage(systemName: "suit.heart.fill", withConfiguration: UIImage.mediumConfiguration)
    }
    
    public class var filmFill: UIImage? {
        return UIImage(systemName: "film.fill", withConfiguration: UIImage.mediumConfiguration)
    }
    
    public class var film: UIImage? {
        return UIImage(systemName: "film", withConfiguration: UIImage.mediumConfiguration)
    }
    
    public class var share: UIImage? {
        return UIImage(systemName: "square.and.arrow.up", withConfiguration: UIImage.mediumConfiguration)
    }
    
    public class var sucsses: UIImage? {
        return UIImage(systemName: "checkmark", withConfiguration: UIImage.lightConfiguration)
    }
    
    public class var warning: UIImage? {
        return UIImage(systemName: "exclamationmark.triangle", withConfiguration: UIImage.lightConfiguration)
    }
    
    public class var error: UIImage? {
        return UIImage(systemName: "xmark", withConfiguration: UIImage.lightConfiguration)
    }
    
    public class var moviePoster: UIImage? {
        return UIImage(named: "movie_poster")
    }
    
    public class var trailerPoster: UIImage? {
        return UIImage(named: "trailer_poster")
    }
    
    public class var dismiss: UIImage? {
        return UIImage(systemName: "xmark", withConfiguration: UIImage.mediumConfiguration)
    }
}

