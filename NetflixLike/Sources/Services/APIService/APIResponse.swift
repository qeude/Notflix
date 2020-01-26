//
//  APIResponse.swift
//  NetflixLike
//
//  Created by Quentin Eude on 26/01/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import Foundation

struct APIResponse<Results: Decodable>: Decodable {
    let page: Int?
    let totalResults: Int?
    let totalPages: Int?
    let results: Results?

    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}
