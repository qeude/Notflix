//
//  TVSeason.swift
//  NetflixLike
//
//  Created by Quentin Eude on 11/05/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import Foundation
struct TVSeason: Decodable, Encodable {
    let id: Int
    let name: String
    let overview: String?
    let seasonNumber: Int
    let posterPath: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case overview
        case seasonNumber = "season_number"
        case posterPath = "poster_path"
    }
}
