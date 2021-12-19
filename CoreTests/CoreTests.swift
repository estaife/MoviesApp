//
//  CoreTests.swift
//  CoreTests
//
//  Created by Estaife Lima on 29/10/21.
//

import XCTest
@testable import Core

class EnvironmentTests: XCTestCase {
    
    func testEnvironmentVariables() {
        XCTAssertEqual(Environment().baseImageURLString, "https://image.tmdb.org/t/p/")
        XCTAssertEqual(Environment().apiKey, "8b743bf189292c45c19e1645ad0b4be7") // TODO: - Overshadow
        XCTAssertEqual(Environment().baseURLString, "https://api.themoviedb.org/3")
    }
}
