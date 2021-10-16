//
//  AlertViewModel.swift
//  Presenter
//
//  Created by Estaife Lima on 16/10/21.
//

import Foundation

public struct AlertViewModel: Equatable {
    public var title: String
    public var message: String
    
    public init(title: String, message: String) {
        self.title = title
        self.message = message
    }
}
