//
//  Movie.swift
//  NetflixLike
//
//  Created by Quentin Eude on 07/10/2019.
//  Copyright © 2019 Quentin Eude. All rights reserved.
//

import Foundation
struct Movie: Decodable {
    let id: Int
    let title: String
    let overview: String?
    let popularity: Double
    let voteAverage: Double
    let video: Bool
    let adult: Bool
    let voteCount: Int
    let genreIds: [Int]?
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case popularity
        case voteAverage = "vote_average"
        case video
        case adult
        case voteCount = "vote_count"
        case genreIds = "genre_ids"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
    }
}
