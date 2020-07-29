//
//  APIEndpoints+Movies.swift
//  Notflix
//
//  Created by Quentin Eude on 11/03/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import Foundation

extension APIEndpoints {
    static let popularMovies = APIRequest<APIResponseList<Movie>>(path: "movie/popular")
    static let topRatedMovies = APIRequest<APIResponseList<Movie>>(path: "movie/top_rated")
    static let movieGenres = APIRequest<APIResponseGenres>(path: "genre/movie/list")
    static func recommendationsMovies(movieId: Int) -> APIRequest<APIResponseList<Movie>> { return APIRequest(path: "movie/\(movieId)/recommendations") }
    static func movie(movieId: Int) -> APIRequest<Movie> { return APIRequest(path: "movie/\(movieId)")}
    static func moviesForGenre(genreId: Int) -> APIRequest<APIResponseList<Movie>> {
        return APIRequest(
            path: "discover/movie",
            parameters: [
                "with_genres": String(genreId)
            ]
        )
    }
    static func movieCredits(movieId: Int) -> APIRequest<APIResponseCredits> { return APIRequest(path: "movie/\(movieId)/credits")}
    static func searchMovies(for text: String) -> APIRequest<APIResponseList<Movie>> {
        return APIRequest(
            path: "search/movie",
            parameters: [
                "query": text
            ]
        )}
}
