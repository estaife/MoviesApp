//
//  PresenterTests.swift
//  PresenterTests
//
//  Created by Estaife Lima on 11/10/21.
//

import XCTest
import Domain
@testable import Presenter

class PopularMoviesPresenterTests: XCTestCase {
    
    var presentPopularMoviesWasCalled: Bool = false
    var presentPopularMoviesExpectation: XCTestExpectation!
    
    var error: DomainError?
    var presentErrorExpectation: XCTestExpectation!
    
    func testFetchPopularMoviesSuccess() {

        //Given
        let (sut, useCaseSpy, _) = createSut()
        let testExpectation = XCTestExpectation(description: "waiting for presentPopularMovies")
        presentPopularMoviesExpectation = testExpectation

        //When
        useCaseSpy.completionWithSuccess(movieResultsSuccess)
        sut.fetchPopularMovies()

        //Then
        XCTAssertTrue(presentPopularMoviesWasCalled)
        wait(for: [testExpectation], timeout: 5)
    }

    func testFetchPopularMoviesError() {

        //Given
        let (sut, useCaseSpy, _) = createSut()
        let testExpectation = XCTestExpectation(description: "waiting for presentError")
        presentErrorExpectation = testExpectation
        let domainError = DomainError(internalError: .unknown)

        //When
        useCaseSpy.completionWithError(domainError)
        sut.fetchPopularMovies()

        //Then
        XCTAssertEqual(error, domainError)
        wait(for: [testExpectation], timeout: 5)
    }
    
    func testFetchPopularMoviesErrorMaximumPagesReached() {
        
        //Given
        let (sut, useCaseSpy, _) = createSut()
        presentErrorExpectation = XCTestExpectation(description: "waiting for presentError")
        presentPopularMoviesExpectation = XCTestExpectation(description: "waiting for presentPopularMovies")
        let domainError = DomainError(internalError: .maximumPagesReached)
        
        //When
        useCaseSpy.completionWithSuccess(movieResultsError)
        sut.fetchPopularMovies()
        sut.fetchPopularMovies()
        
        //Then
        XCTAssertEqual(error, domainError)
        wait(for: [presentErrorExpectation, presentPopularMoviesExpectation], timeout: 5)
    }
    
    func testFetchPopularMoviesLoadingView() {

        //Given
        let (sut, useCaseSpy, loadingView) = createSut()
        let testExpectation = XCTestExpectation(description: "waiting for presentPopularMovies")
        presentPopularMoviesExpectation = testExpectation

        //When
        useCaseSpy.completionWithSuccess(movieResultsSuccess)
        sut.fetchPopularMovies()
        
        //Then
        let result = XCTWaiter.wait(for: [presentPopularMoviesExpectation], timeout: 5)
        switch(result) {
        case .completed:
            XCTAssertTrue(presentPopularMoviesWasCalled)
            XCTAssertFalse(loadingView.isLoading)
        default:
            XCTAssertTrue(loadingView.isLoading)
        }
    }
}

extension PopularMoviesPresenterTests: PopularMoviesPresenterDelegate {
    func presentPopularMovies(_ movies: [MovieViewModel]) {
        presentPopularMoviesWasCalled.toggle()
        presentPopularMoviesExpectation.fulfill()
    }
    
    func presentError(_ error: DomainError) {
        self.error = error
        presentErrorExpectation.fulfill()
    }
}

extension PopularMoviesPresenterTests {
    
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
    
    var movieResultsError: MovieResults {
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
            totalPages: 1,
            totalResults: 1
        )
    }
    
    func createSut() -> (sut: PopularMoviesPresenter, useCaseSpy: PopularMoviesUseCaseSpy, loadingViewSpy: LoadingViewSpy) {
        let useCaseSpy = PopularMoviesUseCaseSpy()
        let loadingViewSpy = LoadingViewSpy()
        let presenter = PopularMoviesPresenter(
            popularMoviesUseCase: useCaseSpy,
            loadingView: loadingViewSpy,
            delegate: self
        )
        return (presenter, useCaseSpy, loadingViewSpy)
    }
}
