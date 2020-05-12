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
        let publisher = APIClient().send(APIEndpoints.popularTVShows)

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
        let publisher = APIClient().send(APIEndpoints.topRatedTVShows)

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

        let publisher = APIClient().send(APIEndpoints.tvShow(tvShowId: 1402))

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
        guard let seasons = tvShow?.seasons else {
            fatalError()
        }
        XCTAssertGreaterThan(seasons.count, 0)
    }

    func testFetchRecommendationsTVShows() {
        let tvShow = anyTVShow()

        let publisher = APIClient().send(APIEndpoints.recommendationsTVShows(tvShowId: tvShow.id))

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

    func testGetTVSeason() {
        var episodes: [Episode]?

        let publisher = APIClient().send(APIEndpoints.tvSeason(tvShowId: 1402, tvSeasonNumber: 1))

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
            episodes = response.episodes
            expectationReceive.fulfill()
        })
        // Disable never used warning
        _ = cancellable

        wait(for: [expectationFinished, expectationReceive], timeout: 5.0)
        XCTAssertNotNil(episodes)
        XCTAssertEqual(episodes?.count, 6)
    }

    func testFetchTvGenres() {
        let publisher = APIClient().send(APIEndpoints.tvShowGenres)

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
            XCTAssertGreaterThan(response.genres.count, 0)
            expectationReceive.fulfill()
        })
        // Disable never used warning
        _ = cancellable

        wait(for: [expectationFinished, expectationReceive], timeout: 5.0)
    }

    func testFetchTvShowsForGenres() {
        let publisher = APIClient().send(APIEndpoints.tvShowsForGenres(genreId: 12))

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
            response.results.forEach { tvShow in
                XCTAssert(tvShow.genreIds?.contains(12) == true)
            }
            expectationReceive.fulfill()
        })
        // Disable never used warning
        _ = cancellable

        wait(for: [expectationFinished, expectationReceive], timeout: 5.0)
    }
}
