//
//  Actor.swift
//  Notflix
//
//  Created by Quentin Eude on 16/05/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import Foundation
struct Actor: Decodable, Identifiable {
    let id: Int
    let name: String?
    let character: String?
    let order: Int?
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case character
        case order
        case profilePath = "profile_path"
    }
}
