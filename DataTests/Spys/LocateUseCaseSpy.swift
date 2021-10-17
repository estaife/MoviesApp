//
//  LocateUseCaseSpy.swift
//  DataTests
//
//  Created by Estaife Lima on 17/10/21.
//

import Domain

public class LocateUseCaseSpy: LocateUseCaseProtocol {
    
    let mockResult: String
    
    init(mockResult: String) {
        self.mockResult = mockResult
    }
    
    public func getCurrentLocate() -> String {
        mockResult
    }
}
