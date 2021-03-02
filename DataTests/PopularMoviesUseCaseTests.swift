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
        let (sut, httpGetClientSpy) = createSut(url: url)
        
        //When
        sut.getAllPopularMovies(page: page) { _ in }
        httpGetClientSpy.completeWith(data: movieResultsSuccess.data!)
        
        //Then
        XCTAssertEqual(httpGetClientSpy.url.first, url)
    }
    
    func testGetAllPopularMoviesWithSuccess() {
        
        //Given
        let (sut, httpGetClientSpy) = createSut(url: url)
        let expectedResult: Result<MovieResults, DomainError> = .success(movieResultsSuccess)
        
        //When
        let expect = expectation(description: "Waiting for popular movies")
        sut.getAllPopularMovies(page: page) { receivedResult in
            switch (expectedResult, receivedResult) {
            case (.failure(let expectedError), .failure(let receivedError)):
                XCTAssertEqual(expectedError, receivedError)
            case (.success(let expectedModel), .success(let receivedModel)):
                XCTAssertEqual(expectedModel, receivedModel)
                XCTAssertEqual(expectedModel.page, receivedModel.page)
                XCTAssertEqual(expectedModel.totalPages, receivedModel.totalPages)
                XCTAssertEqual(expectedModel.results, receivedModel.results)
            default: XCTFail("Fail, because expected and received not equal")
            }
            expect.fulfill()
        }
        httpGetClientSpy.completeWith(data: movieResultsSuccess.data!)
        
        //Then
        wait(for: [expect], timeout: 1)
    }
}

extension PopularMoviesUseCaseTests {
    var movieResultsSuccess: MovieResults {
        let simpleMovieResponse = SimpleMovieResponse(posterPath: nil, releaseDate: "2021-01-01", identifier: 1, title: "Movie Test", popularity: 0.8)
        let movieResults = MovieResults(page: 1, results: [simpleMovieResponse], totalPages: 10, totalResults: 1)
        return movieResults
    }
    
    var url: URL {
        URL(string: "https://test.com")!
    }
    
    var page: String {
        "0"
    }
    
    func createSut(url: URL) -> (sut: PopularMoviesUseCase, httpGetClientSpy: HTTPGetClientSpy) {
        let httpGetClientSpy = HTTPGetClientSpy()
        let sut = PopularMoviesUseCase(httpGetClient: httpGetClientSpy, url: url)
        return (sut, httpGetClientSpy)
    }
}
