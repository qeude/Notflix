//
//  APIEndpoints+TVShows.swift
//  NetflixLike
//
//  Created by Quentin Eude on 11/03/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import Foundation

extension APIEndpoints {
    static let popularTVShows = APIRequest<APIResponseList<TVShow>>(path: "tv/popular")
    static let topRatedTVShows = APIRequest<APIResponseList<TVShow>>(path: "tv/top_rated")
    static func recommendationsTVShows(tvShowId: Int) -> APIRequest<APIResponseList<TVShow>> { return APIRequest(path: "tv/\(tvShowId)/recommendations") }
    static func tvShow(tvShowId: Int) -> APIRequest<TVShow> { return APIRequest(path: "tv/\(tvShowId)")}
}
