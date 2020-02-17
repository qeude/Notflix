//
//  MoviesAPIService.swift
//  NetflixLikeTests
//
//  Created by Quentin Eude on 26/01/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import XCTest
import Combine

@testable import NetflixLike

class MoviesAPIService: XCTestCase {
    func testFetchPoupularMovies() {
        let publisher = APIClient().send(GetPopularMovies())

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
            XCTAssertGreaterThan(response.count, 0)
            expectationReceive.fulfill()
        })

        wait(for: [expectationFinished, expectationReceive, expectationFailure], timeout: 5.0)
    }
}
