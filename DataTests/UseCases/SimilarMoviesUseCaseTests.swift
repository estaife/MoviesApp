//
//  SimilarMoviesUseCaseTests.swift
//  DataTests
//
//  Created by Estaife Lima on 31/10/21.
//

import XCTest
import Domain
@testable import Data

class SimilarMoviesUseCaseTests: XCTestCase {
    
    func testGetAllSimilarMoviesShouldCallRequesterHTTPWithCorrectRequest() {
        
        //Given
        let (sut, requesterHTTPSpy) = createSut(mockResult: "pt-BR")
        
        //When
        sut.getAllSimilarMovies(identifier: identifier) { _ in }
        requesterHTTPSpy.success =  movieResultsSuccess
        
        //Then
        XCTAssertEqual(requesterHTTPSpy.url, requesterHTTPSpy.request?.url)
        XCTAssertEqual(requesterHTTPSpy.request?.path, "/movie/\(identifier)/similar")
        XCTAssertEqual(requesterHTTPSpy.request?.method, .get)
        XCTAssertEqual(requesterHTTPSpy.request?.parameters?.contains { existLanguageValueAndKey(dic: $0) }, true)
        XCTAssertNil(requesterHTTPSpy.request?.body)
        XCTAssertNil(requesterHTTPSpy.request?.headers)
    }
    
    func testGetAllSimilarMoviesWithSuccess() {

        //Given
        let (sut, requesterHTTPSpy) = createSut(mockResult: "")
        let expectedResult: Result<MovieResults, DomainError> = .success(movieResultsSuccess)

        //When
        let expect = expectation(description: "Waiting for Similar movies")
        sut.getAllSimilarMovies(identifier: identifier) { receivedResult in
            switch (expectedResult, receivedResult) {
            case (.success(let expectedModel), .success(let receivedModel)):
                XCTAssertEqual(expectedModel, receivedModel)
                XCTAssertEqual(expectedModel.page, receivedModel.page)
                XCTAssertEqual(expectedModel.totalPages, receivedModel.totalPages)
                XCTAssertEqual(expectedModel.results, receivedModel.results)
            case (.failure(let expectedError), .failure(let receivedError)):
                XCTAssertEqual(expectedError, receivedError)
            default: XCTFail("Fail, because expected and received not equal")
            }
            expect.fulfill()
        }
        requesterHTTPSpy.success =  movieResultsSuccess

        //Then
        wait(for: [expect], timeout: 1)
    }

    func testGetAllSimilarMoviesWithError() {

        //Given
        let (sut, requesterHTTPSpy) = createSut(mockResult: "")
        let expectedResult: Result<MovieResults, DomainError> = .failure(.init(internalError: .unknown))

        //When
        let expect = expectation(description: "Wainting for error")
        sut.getAllSimilarMovies(identifier: identifier) { receivedResult in
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

    func testGetAllSimilarMoviesShouldNotSutHasDeallocated() {

        //Given
        let requesterHTTPSpy = RequesterHTTPSpy()
        let locateUseCaseSpy = LocateUseCaseSpy(mockResult: "")
        var sut: SimilarMoviesUseCase? = SimilarMoviesUseCase(
            requesterHTTP: requesterHTTPSpy,
            locate: locateUseCaseSpy
        )
        var result: Result<MovieResults, DomainError>?

        //When
        sut?.getAllSimilarMovies(identifier: identifier) { result = $0 }
        sut = nil
        requesterHTTPSpy.success =  movieResultsSuccess

        //Then
        XCTAssertNil(result)
    }
}

extension SimilarMoviesUseCaseTests {
    
    func existLanguageValueAndKey(dic: Dictionary<String, String>.Element) -> Bool {
        return dic.value == "pt-BR" && dic.key == "language" ? true : false
    }
    
    var movieResultsSuccess: MovieResults {
        let simpleMovieResponse = SimpleMovieResponse(
            posterPath: nil,
            releaseDate: "2021-01-01",
            identifier: 1,
            title: "Movie Test",
            voteAverage: 0.8
        )
        return MovieResults(
            page: 1,
            results: [simpleMovieResponse],
            totalPages: 10,
            totalResults: 1
        )
    }
    
    var identifier: String {
        "13931"
    }
    
    func createSut(
        mockResult: String,
        file: StaticString = #file,
        line: UInt = #line
    ) -> (sut: SimilarMoviesUseCase, requesterHTTPSpy: RequesterHTTPSpy) {
        let requesterHTTPSpy = RequesterHTTPSpy()
        let locateUseCaseSpy = LocateUseCaseSpy(mockResult: mockResult)
        let sut = SimilarMoviesUseCase(
            requesterHTTP: requesterHTTPSpy,
            locate: locateUseCaseSpy
        )
        addTeardownBlock { [weak sut] in
            XCTAssertNil(sut, file: file, line: line)
        }
        return (sut, requesterHTTPSpy)
    }
}

