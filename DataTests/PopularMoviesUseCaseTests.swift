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
        sut.getAllPopularMovies(page: "1") { _ in }
        httpGetClientSpy.completeWith(data: movieResultsData)
        
        //Then
        XCTAssertEqual(httpGetClientSpy.url.first, url)
    }
}

extension PopularMoviesUseCaseTests {
    var movieResultsData: Data {
        let simpleMovieResponse = SimpleMovieResponse(posterPath: nil, releaseDate: "2021-01-01", identifier: 1, title: "Movie Test", popularity: 0.8)
        let movieResults = MovieResults(page: 1, results: [simpleMovieResponse], totalPages: 10, totalResults: 1)
        return movieResults.data!
    }
    
    var url: URL {
        URL(string: "https://test.com")!
    }
    
    func createSut(url: URL) -> (sut: PopularMoviesUseCase, httpGetClientSpy: HTTPGetClientSpy) {
        let httpGetClientSpy = HTTPGetClientSpy()
        let sut = PopularMoviesUseCase(httpGetClient: httpGetClientSpy, url: url)
        return (sut, httpGetClientSpy)
    }
}
