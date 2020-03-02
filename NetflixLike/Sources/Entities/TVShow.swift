//
//  TVShow.swift
//  NetflixLike
//
//  Created by Quentin Eude on 02/03/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import Foundation
struct TVShow: Decodable {
    let id: Int
    let title: String
    let overview: String?
    let popularity: Double
    let voteAverage: Double
    let voteCount: Int
    let genreIds: [Int]?
    let posterPath: String?
    let backdropPath: String?
    let firstAirDate: String?

    enum CodingKeys: String, CodingKey {
        case id
        case title = "name"
        case overview
        case popularity
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case genreIds = "genre_ids"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case firstAirDate = "first_air_date"
    }
}
