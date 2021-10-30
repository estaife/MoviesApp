//
//  BundleModule.swift.swift
//  View
//
//  Created by Estaife Lima on 21/10/21.
//

import Foundation.NSBundle

public final class BundleModule {
    public init() { }
    
    public static var bundle: Bundle {
        return Bundle(for: BundleModule.self)
    }
}
