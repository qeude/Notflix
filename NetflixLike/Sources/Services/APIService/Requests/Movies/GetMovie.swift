//
//  GetMovie.swift
//  NetflixLike
//
//  Created by Quentin Eude on 18/02/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import Foundation

struct GetMovie: APIRequest {
    typealias Response = Movie

    var resourceName: String {
        return "movie/\(movieId)"
    }

    let movieId: Int

    init(movieId: Int) {
        self.movieId = movieId
    }
}
