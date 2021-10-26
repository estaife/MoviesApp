//
//  DetailsMovieUseCaseTests.swift
//  DataTests
//
//  Created by Estaife Lima on 26/10/21.
//

import XCTest
import Domain
@testable import Data

class DetailsMovieUseCaseTests: XCTestCase {
    
    func testGetDetailsMovieShouldCallRequesterHTTPWithCorrectRequest() {
        
        //Given
        let (sut, requesterHTTPSpy) = createSut(mockResult: "pt-BR")
        
        //When
        sut.getDetailsMovie(identifier: identifier) { _ in }
        requesterHTTPSpy.success =  completeMovieResponse
        
        //Then
        XCTAssertEqual(requesterHTTPSpy.url, requesterHTTPSpy.request?.url)
        XCTAssertEqual(requesterHTTPSpy.request?.path, "/movie/" + identifier)
        XCTAssertEqual(requesterHTTPSpy.request?.method, .get)
        XCTAssertEqual(requesterHTTPSpy.request?.parameters?.contains { existLanguageValueAndKey(dic: $0) }, true)
        XCTAssertNil(requesterHTTPSpy.request?.body)
        XCTAssertNil(requesterHTTPSpy.request?.headers)
    }
    
    func testGetDetailsMovieWithSuccess() {

        //Given
        let (sut, requesterHTTPSpy) = createSut(mockResult: "")
        let expectedResult: Result<CompleteMovieResponse, DomainError> = .success(completeMovieResponse)

        //When
        let expect = expectation(description: "Waiting for popular movies")
        sut.getDetailsMovie(identifier: identifier) { receivedResult in
            switch (expectedResult, receivedResult) {
            case (.success(let expectedModel), .success(let receivedModel)):
                XCTAssertEqual(expectedModel, receivedModel)
                XCTAssertEqual(expectedModel.identifier, receivedModel.identifier)
                XCTAssertEqual(expectedModel.voteAverage, receivedModel.voteAverage)
                XCTAssertEqual(expectedModel.genres.isEmpty, receivedModel.genres.isEmpty)
            case (.failure(let expectedError), .failure(let receivedError)):
                XCTAssertEqual(expectedError, receivedError)
            default: XCTFail("Fail, because expected and received not equal")
            }
            expect.fulfill()
        }
        requesterHTTPSpy.success =  completeMovieResponse

        //Then
        wait(for: [expect], timeout: 1)
    }

    func testGetDetailsMovieWithError() {

        //Given
        let (sut, requesterHTTPSpy) = createSut(mockResult: "")
        let expectedResult: Result<MovieResults, DomainError> = .failure(.init(internalError: .unknown))

        //When
        let expect = expectation(description: "Wainting for error")
        sut.getDetailsMovie(identifier: identifier) { receivedResult in
            switch (expectedResult, receivedResult) {
            case (.failure(let expectedError), .failure(let receivedError)):
                XCTAssertEqual(expectedError, receivedError)
            default: XCTFail("Fail, because expected and received not equal")
            }
            expect.fulfill()
        }
        requesterHTTPSpy.error = .init(internalError: .unknown)

        //Then
        wait(for: [expect], timeout: 1)
    }
//
    func testGetDetailsMovieShouldNotSutHasDeallocated() {

        //Given
        let requesterHTTPSpy = RequesterHTTPSpy()
        let locateUseCaseSpy = LocateUseCaseSpy(mockResult: "")
        var sut: DetailsMovieUseCase? = DetailsMovieUseCase(
            requesterHTTP: requesterHTTPSpy,
            locate: locateUseCaseSpy
        )
        var result: Result<CompleteMovieResponse, DomainError>?

        //When
        sut?.getDetailsMovie(identifier: identifier) { result = $0 }
        sut = nil
        requesterHTTPSpy.success =  completeMovieResponse

        //Then
        XCTAssertNil(result)
    }
}

extension DetailsMovieUseCaseTests {
    
    func existLanguageValueAndKey(dic: Dictionary<String, String>.Element) -> Bool {
        return dic.value == "pt-BR" && dic.key == "language" ? true : false
    }
    
    var completeMovieResponse: CompleteMovieResponse {
        .init(
            title: "title",
            identifier: 13931,
            genres: [],
            overview: "overview",
            posterPath: "posterPath",
            backdropPath: "backdropPath",
            releaseDate: "releaseDate",
            tagline: "tagline",
            voteAverage: 0.0,
            videos: .init(
                results: []
            ),
            images: .init(
                backdrops: [],
                posters: []
            )
        )
    }
    
    var identifier: String {
        "13931"
    }
    
    func createSut(
        mockResult: String,
        file: StaticString = #file,
        line: UInt = #line
    ) -> (sut: DetailsMovieUseCase, requesterHTTPSpy: RequesterHTTPSpy) {
        let requesterHTTPSpy = RequesterHTTPSpy()
        let locateUseCaseSpy = LocateUseCaseSpy(mockResult: mockResult)
        let sut = DetailsMovieUseCase(
            requesterHTTP: requesterHTTPSpy,
            locate: locateUseCaseSpy
        )
        addTeardownBlock { [weak sut] in
            XCTAssertNil(sut, file: file, line: line)
        }
        return (sut, requesterHTTPSpy)
    }
}
