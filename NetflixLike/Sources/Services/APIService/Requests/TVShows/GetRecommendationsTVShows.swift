//
//  GetRecommendationsTVShows.swift
//  NetflixLike
//
//  Created by Quentin Eude on 02/03/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import Foundation

struct GetRecommendationsTVShows: APIRequest {
    typealias Response = APIResponseList<TVShow>

    var resourceName: String {
        return "tv/\(tvShowId)/recommendations"
    }

    let tvShowId: Int

    init(tvShowId: Int) {
        self.tvShowId = tvShowId
    }
}
