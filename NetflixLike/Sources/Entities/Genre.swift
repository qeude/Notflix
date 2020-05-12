//
//  Genre.swift
//  NetflixLike
//
//  Created by Quentin Eude on 20/03/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import Foundation
struct Genre: Decodable, Identifiable {
    let id: Int
    let name: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}
