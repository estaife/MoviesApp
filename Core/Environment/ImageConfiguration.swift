//
//  ImageConfiguration.swift
//  Domain
//
//  Created by Estaife Lima on 20/10/21.
//

import Foundation

public enum QualityImage: String {
    case original
    case w500
}

public enum TypeImage {
    case poster
    case backdrop
}

public struct ImageConfiguration {
    let quality: QualityImage
    let type: TypeImage
}
