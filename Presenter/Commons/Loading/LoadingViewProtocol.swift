//
//  LoadingViewProtocol.swift
//  Presenter
//
//  Created by Estaife Lima on 16/10/21.
//

import Foundation

public protocol LoadingViewProtocol {
    var isLoading: Bool { get }
    func start()
    func stop()
}
