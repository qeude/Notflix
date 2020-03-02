//
//  TVShowsAPIServiceTests.swift
//  NetflixLikeTests
//
//  Created by Quentin Eude on 02/03/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import XCTest
import Combine

@testable import NetflixLike

class TVShowsAPIServiceTests: NetflixLikeTests {
    func testFetchPopularTVShows() {
        let publisher = APIClient().send(GetPopularTVShows())

        XCTAssertNotNil(publisher)

        let expectationFinished = XCTestExpectation(description: "finished")
        let expectationReceive = XCTestExpectation(description: "receiveValue")
        let expectationFailure = XCTestExpectation(description: "failure")
        expectationFailure.isInverted = true

        let cancellable = publisher.sink (receiveCompletion: { (completion) in
            switch completion {
            case .failure:
                expectationFailure.fulfill()
            case .finished:
                expectationFinished.fulfill()
            }
        }, receiveValue: { response in
            XCTAssertNotNil(response)
            XCTAssertGreaterThan(response.results.count, 0)
            expectationReceive.fulfill()
        })
        // Disable never used warning
        _ = cancellable

        wait(for: [expectationFinished, expectationReceive], timeout: 5.0)
    }

    func testFetchTopRatedTVShows() {
        let publisher = APIClient().send(GetTopRatedTVShows())

        XCTAssertNotNil(publisher)

        let expectationFinished = XCTestExpectation(description: "finished")
        let expectationReceive = XCTestExpectation(description: "receiveValue")
        let expectationFailure = XCTestExpectation(description: "failure")
        expectationFailure.isInverted = true

        let cancellable = publisher.sink (receiveCompletion: { (completion) in
            switch completion {
            case .failure:
                expectationFailure.fulfill()
            case .finished:
                expectationFinished.fulfill()
            }
        }, receiveValue: { response in
            XCTAssertNotNil(response)
            XCTAssertGreaterThan(response.results.count, 0)
            expectationReceive.fulfill()
        })
        // Disable never used warning
        _ = cancellable

        wait(for: [expectationFinished, expectationReceive], timeout: 5.0)
    }

    func testGetTVShow() {
        var tvShow: TVShow?

        let publisher = APIClient().send(GetTVShow(tvShowId: 1402))

        XCTAssertNotNil(publisher)

        let expectationFinished = XCTestExpectation(description: "finished")
        let expectationReceive = XCTestExpectation(description: "receiveValue")
        let expectationFailure = XCTestExpectation(description: "failure")
        expectationFailure.isInverted = true

        let cancellable = publisher.sink (receiveCompletion: { (completion) in
            switch completion {
            case .failure:
                expectationFailure.fulfill()
            case .finished:
                expectationFinished.fulfill()
            }
        }, receiveValue: { response in
            XCTAssertNotNil(response)
            tvShow = response
            expectationReceive.fulfill()
        })
        // Disable never used warning
        _ = cancellable

        wait(for: [expectationFinished, expectationReceive], timeout: 5.0)
        XCTAssertNotNil(tvShow)
        XCTAssertEqual(tvShow?.title, "The Walking Dead")
    }

    func testFetchRecommendationsTVShows() {
        let tvShow = anyTVShow()

        let publisher = APIClient().send(GetRecommendationsTVShows(tvShowId: tvShow.id))

        XCTAssertNotNil(publisher)

        let expectationFinished = XCTestExpectation(description: "finished")
        let expectationReceive = XCTestExpectation(description: "receiveValue")
        let expectationFailure = XCTestExpectation(description: "failure")
        expectationFailure.isInverted = true

        let cancellable = publisher.sink (receiveCompletion: { (completion) in
            switch completion {
            case .failure:
                expectationFailure.fulfill()
            case .finished:
                expectationFinished.fulfill()
            }
        }, receiveValue: { response in
            XCTAssertNotNil(response)
            XCTAssertGreaterThan(response.results.count, 0)
            expectationReceive.fulfill()
        })
        // Disable never used warning
        _ = cancellable

        wait(for: [expectationFinished, expectationReceive], timeout: 5.0)
    }
}
