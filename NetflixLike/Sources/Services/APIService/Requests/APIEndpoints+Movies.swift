//
//  APIEndpoints+Movies.swift
//  NetflixLike
//
//  Created by Quentin Eude on 11/03/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import Foundation

extension APIEndpoints {
    static let popularMovies = APIRequest<APIResponseList<Movie>>(path: "movie/popular")
    static let topRatedMovies = APIRequest<APIResponseList<Movie>>(path: "movie/top_rated")
    static func recommendationsMovies(movieId: Int) -> APIRequest<APIResponseList<Movie>> { return APIRequest(path: "movie/\(movieId)/recommendations") }
    static func movie(movieId: Int) -> APIRequest<Movie> { return APIRequest(path: "movie/\(movieId)")}
}
