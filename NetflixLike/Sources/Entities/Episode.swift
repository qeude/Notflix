//
//  Episode.swift
//  NetflixLike
//
//  Created by Quentin Eude on 11/05/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import Foundation
struct Episode: Decodable, Encodable {
    let id: Int
    let name: String?
    let airDate: String?
    let episodeNumber: Int
    let overview: String?
    let seasonNumber: Int
    let stillPath: String?
    let voteAverage: Double
    let voteCount: Int


    var stillUrl: URL? {
           guard let stillPath = stillPath else {
               return nil
           }
           let url = URL(string: "\(APIClient.baseImageStringUrl)\(stillPath)")
           return url
       }

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case airDate = "air_date"
        case episodeNumber = "episode_number"
        case overview
        case seasonNumber = "season_number"
        case stillPath = "still_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
