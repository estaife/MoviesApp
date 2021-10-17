//
//  Locate.swift
//  Data
//
//  Created by Estaife Lima on 16/10/21.
//

import Domain

public final class LocateUseCase: LocateUseCaseProtocol {
    
    // MARK: - Properties
    private let locale: Locale
    
    // MARK: - INITIALIZERS
    public required init(locale: Locale) {
        self.locale = locale
    }
}

// MARK: - LocateProtocol
extension LocateUseCase {
    public func getCurrentLocate() -> String {
        if let languageCode = locale.languageCode,
            let regionCode = locale.regionCode {
            return "\(languageCode)-\(regionCode)"
        }
        return "en-US"
    }
}
