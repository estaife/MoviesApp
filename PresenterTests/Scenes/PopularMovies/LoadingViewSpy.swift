//
//  LoadingViewSpy.swift
//  PresenterTests
//
//  Created by Estaife Lima on 19/10/21.
//

import Presenter

class LoadingViewSpy {
    var mockedIsLoading: Bool = false
}

extension LoadingViewSpy: LoadingViewProtocol {
    
    var isLoading: Bool {
        mockedIsLoading
    }

    func start() {
        mockedIsLoading = true
    }
    
    func stop() {
        mockedIsLoading = false
    }
}
