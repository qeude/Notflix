//
//  MoviesAPIService.swift
//  NetflixLikeTests
//
//  Created by Quentin Eude on 26/01/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import XCTest

@testable import NetflixLike
class MoviesAPIService: XCTestCase {

    func testFetchPoupularMovies() {
        XCTAssertNoThrow(
            APIClient().send(GetPopularMovies(), completion: { response in
                switch response {
                case .success(let movies):
                    XCTAssertGreaterThan(movies.count, 0)
                case .failure(let error):
                    XCTFail("Failed with error : \(error)")
                }
            })
        )
    }
}
