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
        .init(systemName: "suit.heart", withConfiguration: UIImage.mediumConfiguration)
    }
    
    public class var heartFill: UIImage? {
        .init(systemName: "suit.heart.fill", withConfiguration: UIImage.mediumConfiguration)
    }
    
    public class var filmFill: UIImage? {
        .init(systemName: "film.fill", withConfiguration: UIImage.mediumConfiguration)
    }
    
    public class var film: UIImage? {
        .init(systemName: "film", withConfiguration: UIImage.mediumConfiguration)
    }
    
    public class var share: UIImage? {
        .init(systemName: "square.and.arrow.up", withConfiguration: UIImage.mediumConfiguration)
    }
    
    public class var success: UIImage? {
        .init(systemName: "checkmark", withConfiguration: UIImage.lightConfiguration)
    }
    
    public class var warning: UIImage? {
        .init(systemName: "exclamationmark.triangle", withConfiguration: UIImage.lightConfiguration)
    }
    
    public class var error: UIImage? {
        .init(systemName: "xmark", withConfiguration: UIImage.lightConfiguration)
    }
    
    public class var moviePoster: UIImage? {
        .init(named: "movie_poster", in: BundleModule.bundle, with: nil)
    }
    
    public class var trailerPoster: UIImage? {
        .init(named: "trailer_poster", in: BundleModule.bundle, with: nil)
    }
    
    public class var dismiss: UIImage? {
        .init(systemName: "xmark", withConfiguration: UIImage.mediumConfiguration)
    }
}

