//
//  GetTopRatedMovies.swift
//  NetflixLike
//
//  Created by Quentin Eude on 18/02/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import Foundation

struct GetTopRatedMovies: APIRequest {
    typealias Response = APIResponseList<Movie>

    var resourceName: String {
        return "movie/top_rated"
    }
}
