//
//  RequesterHTTPTests.swift
//  NetworkingTests
//
//  Created by Estaife Lima on 07/06/20.
//  Copyright © 2020 Estaife Lima. All rights reserved.
//

import XCTest
import Alamofire
import Data
@testable import Networking

class RequesterHTTPTests: XCTestCase {

    func testGetMakeRequestWithUrlAndMethodCorect() throws {
        
        //Given
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [URLProtocolStub.self]
        let session = Session(configuration: configuration)
        let sut = RequesterHTTP(session: session)
        memoryLeakCheckWith(instance: sut)
        
        //When/Then
        expectRequestWith(sut: sut) { (request) in
            XCTAssertEqual(url(path: getRequestSpy.path), request.url)
            XCTAssertEqual("GET", request.httpMethod)
            XCTAssertNil(request.httpBodyStream)
        }
    }
}

extension RequesterHTTPTests {
    func expectRequestWith(sut: RequesterHTTP, completion: @escaping (URLRequest) -> Void) {
        let expect = expectation(description: "waiting")
        let type = GetResponseModel.self
        sut.perform(request: getRequestSpy, type: type) { _ in
            expect.fulfill()
        }
        var request: URLRequest!
        URLProtocolStub.observerRequest { request = $0 }
        wait(for: [expect], timeout: 1)
        completion(request)
    }
}
