//
//  TVShow.swift
//  NetflixLike
//
//  Created by Quentin Eude on 02/03/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import Foundation
struct TVShow: Decodable, Identifiable {
    let id: Int
    let title: String
    let overview: String?
    let popularity: Double
    let voteAverage: Double
    let voteCount: Int
    let genreIds: [Int]?
    let posterPath: String?
    let backdropPath: String?
    let firstAirDate: String

    var posterUrl: URL? {
        guard let posterPath = posterPath else {
            return nil
        }
        let url = URL(string: "\(APIClient.baseImageStringUrl)\(posterPath)")
        return url
    }

    var backdropUrl: URL? {
        guard let backdropPath = backdropPath else {
            return nil
        }
        return URL(string: "\(APIClient.baseImageStringUrl)\(backdropPath)")
    }

    var formattedFirstAirDate: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale.current
        guard let date = formatter.date(from: self.firstAirDate) else {
            return nil
        }
        return date
    }

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
