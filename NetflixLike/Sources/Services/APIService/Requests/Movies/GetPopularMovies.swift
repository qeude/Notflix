//
//  GetPopuplarMovies.swift
//  NetflixLike
//
//  Created by Quentin Eude on 26/01/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import Foundation

struct GetPopularMovies: APIRequest {
    typealias Response = [Movie]

    var resourceName: String {
        return "movie/popular"
    }
}
