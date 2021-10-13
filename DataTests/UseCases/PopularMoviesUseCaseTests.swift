//
//  PopularMoviesUseCaseTests.swift
//  DataTests
//
//  Created by Estaife Lima on 14/09/20.
//

import XCTest
import Domain
@testable import Data

class PopularMoviesUseCaseTests: XCTestCase {
    
    func testGetAllPopularMoviesShouldCallHttpClientWithUrlCorrect() {
        
        //Given
        let (sut, requesterHTTPSpy) = createSut()
        
        //When
        sut.getAllPopularMovies(page: page) { _ in }
        requesterHTTPSpy.completeWith(data: movieResultsSuccess)
        
        //Then
        XCTAssertEqual(requesterHTTPSpy.url, requesterHTTPSpy.request?.url)
    }
    
    func testGetAllPopularMoviesWithSuccess() {

        //Given
        let (sut, requesterHTTPSpy) = createSut()
        let expectedResult: Result<MovieResults, DomainError> = .success(movieResultsSuccess)

        //When
        let expect = expectation(description: "Waiting for popular movies")
        sut.getAllPopularMovies(page: page) { receivedResult in
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
        requesterHTTPSpy.completeWith(data: movieResultsSuccess)

        //Then
        wait(for: [expect], timeout: 1)
    }

    func testGetAllPopularMoviesWithError() {

        //Given
        let (sut, requesterHTTPSpy) = createSut()
        let expectedResult: Result<MovieResults, DomainError> = .failure(.init(internalError: .unknown))

        //When
        let expect = expectation(description: "Wainting for error")
        sut.getAllPopularMovies(page: page) { receivedResult in
            switch (expectedResult, receivedResult) {
            case (.failure(let expectedError), .failure(let receivedError)):
                XCTAssertEqual(expectedError, receivedError)
            default: XCTFail("Fail, because expected and received not equal")
            }
            expect.fulfill()
        }
        requesterHTTPSpy.completeWith(error: .init(internalError: .unknown))

        //Then
        wait(for: [expect], timeout: 1)
    }
//
    func testGetAllPopularMoviesShouldNotSutHasDeallocated() {

        //Given
        let requesterHTTPSpy = RequesterHTTPSpy()
        var sut: PopularMoviesUseCase? = PopularMoviesUseCase(requesterHTTP: requesterHTTPSpy)
        var result: Result<MovieResults, DomainError>?

        //When
        sut?.getAllPopularMovies(page: page) { result = $0 }
        sut = nil
        requesterHTTPSpy.completeWith(data: movieResultsSuccess)

        //Then
        XCTAssertNil(result)
    }
}

extension PopularMoviesUseCaseTests {
    var movieResultsSuccess: MovieResults {
        let simpleMovieResponse = SimpleMovieResponse(
            posterPath: nil,
            releaseDate: "2021-01-01",
            identifier: 1,
            title: "Movie Test",
            popularity: 0.8
        )
        let movieResults = MovieResults(
            page: 1,
            results: [simpleMovieResponse],
            totalPages: 10,
            totalResults: 1
        )
        return movieResults
    }
    
    var page: String {
        "0"
    }
    
    func createSut(
        file: StaticString = #file,
        line: UInt = #line
    ) -> (sut: PopularMoviesUseCase, requesterHTTPSpy: RequesterHTTPSpy) {
        let requesterHTTPSpy = RequesterHTTPSpy()
        let sut = PopularMoviesUseCase(requesterHTTP: requesterHTTPSpy)
        addTeardownBlock { [weak sut] in
            XCTAssertNil(sut, file: file, line: line)
        }
        return (sut, requesterHTTPSpy)
    }
}
