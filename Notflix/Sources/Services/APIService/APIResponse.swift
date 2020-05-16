//
//  APIResponse.swift
//  Notflix
//
//  Created by Quentin Eude on 26/01/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import Foundation

struct APIResponseList<ResultType: Decodable>: Decodable {
    let page: Int?
    let totalResults: Int?
    let totalPages: Int?
    let results: [ResultType]

    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}

struct APIResponseTVSeason: Decodable {
    let episodes: [Episode]

    enum CodingKeys: String, CodingKey {
        case episodes
    }
}

struct APIResponseGenres: Decodable {
    let genres: [Genre]

    enum CodingKeys: String, CodingKey {
        case genres
    }
}

struct APIResponseCredits: Decodable {
    let cast: [Actor]

    enum CodingKeys: String, CodingKey {
        case cast
    }
}
