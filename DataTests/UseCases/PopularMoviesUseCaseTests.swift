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
    
    func testGetAllPopularMoviesShouldCallRequesterHTTPWithCorrectRequest() {
        
        //Given
        let (sut, requesterHTTPSpy) = createSut(mockResult: "pt-BR")
        
        //When
        sut.getAllPopularMovies(page: page) { _ in }
        requesterHTTPSpy.success =  movieResultsSuccess
        
        //Then
        XCTAssertEqual(requesterHTTPSpy.url, requesterHTTPSpy.request?.url)
        XCTAssertEqual(requesterHTTPSpy.request?.path, "/movie/popular")
        XCTAssertEqual(requesterHTTPSpy.request?.method, .get)
        XCTAssertEqual(requesterHTTPSpy.request?.parameters?.contains { existLanguageValueAndKey(dic: $0) }, true)
        XCTAssertNil(requesterHTTPSpy.request?.body)
        XCTAssertNil(requesterHTTPSpy.request?.headers)
    }
    
    func testGetAllPopularMoviesWithSuccess() {

        //Given
        let (sut, requesterHTTPSpy) = createSut(mockResult: "")
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
        requesterHTTPSpy.success =  movieResultsSuccess

        //Then
        wait(for: [expect], timeout: 1)
    }

    func testGetAllPopularMoviesWithError() {

        //Given
        let (sut, requesterHTTPSpy) = createSut(mockResult: "")
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
        requesterHTTPSpy.error = .init(internalError: .unknown)

        //Then
        wait(for: [expect], timeout: 1)
    }

    func testGetAllPopularMoviesShouldNotSutHasDeallocated() {

        //Given
        let requesterHTTPSpy = RequesterHTTPSpy()
        let locateUseCaseSpy = LocateUseCaseSpy(mockResult: "")
        var sut: PopularMoviesUseCase? = PopularMoviesUseCase(
            requesterHTTP: requesterHTTPSpy,
            locate: locateUseCaseSpy
        )
        var result: Result<MovieResults, DomainError>?

        //When
        sut?.getAllPopularMovies(page: page) { result = $0 }
        sut = nil
        requesterHTTPSpy.success =  movieResultsSuccess

        //Then
        XCTAssertNil(result)
    }
}

extension PopularMoviesUseCaseTests {
    
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
    
    var page: String {
        "0"
    }
    
    func createSut(
        mockResult: String,
        file: StaticString = #file,
        line: UInt = #line
    ) -> (sut: PopularMoviesUseCase, requesterHTTPSpy: RequesterHTTPSpy) {
        let requesterHTTPSpy = RequesterHTTPSpy()
        let locateUseCaseSpy = LocateUseCaseSpy(mockResult: mockResult)
        let sut = PopularMoviesUseCase(
            requesterHTTP: requesterHTTPSpy,
            locate: locateUseCaseSpy
        )
        addTeardownBlock { [weak sut] in
            XCTAssertNil(sut, file: file, line: line)
        }
        return (sut, requesterHTTPSpy)
    }
}
