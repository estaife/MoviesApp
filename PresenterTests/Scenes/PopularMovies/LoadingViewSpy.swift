//
//  LoadingSpy.swift
//  PresenterTests
//
//  Created by Estaife Lima on 19/10/21.
//

import Presenter

class LoadingSpy: LoadingViewProtocol {
    var isLoading: Bool { false }
    
    func start() {
        isLoading = true
    }
    
    func stop() {
        isLoading = false
    }
}
