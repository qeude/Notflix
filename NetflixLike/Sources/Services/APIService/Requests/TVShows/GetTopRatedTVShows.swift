//
//  GetTopRatedTVShows.swift
//  NetflixLike
//
//  Created by Quentin Eude on 02/03/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import Foundation

struct GetTopRatedTVShows: APIRequest {
    typealias Response = APIResponseList<TVShow>
    
    var resourceName: String {
        return "tv/top_rated"
    }
}
