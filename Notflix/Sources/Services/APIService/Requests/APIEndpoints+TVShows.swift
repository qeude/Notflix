//
//  APIEndpoints+TVShows.swift
//  Notflix
//
//  Created by Quentin Eude on 11/03/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import Foundation

extension APIEndpoints {
    static let popularTVShows = APIRequest<APIResponseList<TVShow>>(path: "tv/popular")
    static let topRatedTVShows = APIRequest<APIResponseList<TVShow>>(path: "tv/top_rated")
    static let tvShowGenres = APIRequest<APIResponseGenres>(path: "genre/tv/list")
    static func recommendationsTVShows(tvShowId: Int) -> APIRequest<APIResponseList<TVShow>> { return APIRequest(path: "tv/\(tvShowId)/recommendations") }
    static func tvShow(tvShowId: Int) -> APIRequest<TVShow> { return APIRequest(path: "tv/\(tvShowId)")}
    static func tvSeason(tvShowId: Int, tvSeasonNumber: Int) -> APIRequest<APIResponseTVSeason> { return APIRequest(path: "tv/\(tvShowId)/season/\(tvSeasonNumber)")}
    static func tvShowsForGenre(genreId: Int) -> APIRequest<APIResponseList<TVShow>> {
        return APIRequest(
            path: "discover/tv",
            parameters: [
                "with_genres": String(genreId)
            ]
        )
    }
    static func searchTVShows(for text: String) -> APIRequest<APIResponseList<TVShow>> {
           return APIRequest(
               path: "search/tv",
               parameters: [
                   "query": text
               ]
           )}
}
