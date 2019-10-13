//
//  APIServiceTests.swift
//  NetflixLikeTests
//
//  Created by Quentin Eude on 09/10/2019.
//  Copyright © 2019 Quentin Eude. All rights reserved.
//

import XCTest

@testable import NetflixLike
class APIServiceTests: XCTestCase {
    
    func testFetchPopularMovies() {
        XCTAssertNoThrow(
            APIService().fetchPopularMovies(page:  1).done { result in
                let popularMovies = result.data
                XCTAssertFalse(popularMovies.isEmpty)
            }
        )
    }
}
