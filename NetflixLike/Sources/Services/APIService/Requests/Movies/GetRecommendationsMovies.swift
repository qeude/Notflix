//
//  GetRecommendationsMovies.swift
//  NetflixLike
//
//  Created by Quentin Eude on 18/02/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import Foundation

struct GetRecommendationsMovies: APIRequest {
    typealias Response = APIResponseList<Movie>

    var resourceName: String {
        return "movie/\(movieId)/recommendations"
    }

    let movieId: Int

    init(movieId: Int) {
        self.movieId = movieId
    }
}
