//
//  ViewState.swift
//  View
//
//  Created by Estaife Lima on 21/10/21.
//

import Foundation

enum ViewState {
    case loading
    case hasData
    case error
}

protocol ViewStateProtocol {
    func transition(to state: ViewState)
}
