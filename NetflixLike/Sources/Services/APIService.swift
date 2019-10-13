//
//  APIService.swift
//  NetflixLike
//
//  Created by Quentin Eude on 07/10/2019.
//  Copyright © 2019 Quentin Eude. All rights reserved.
//

import Foundation
import Combine
import PromiseKit

enum APIError: Error, LocalizedError {
    case unknown, apiError(reason: String)

    var errorDescription: String? {
        switch self {
        case .unknown:
            return "Unknown error"
        case .apiError(let reason):
            return reason
        }
    }
}

class APIService {
    private let apiKey = "3b426104ae068b7e3222b4d000d29bb5"
    private let baseUrl = URL(string: "https://api.themoviedb.org/3/")
    
    func fetchPopuplarMovies(page: Int = 1) -> Promise<MovieList> {
        guard var urlComponents = URLComponents(string: "https://api.themoviedb.org/3/movie/popular") else { fatalError("Fetch popular movies URL is not correct.") }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "page", value: String(page))
        ]
        
        guard let url = urlComponents.url else { fatalError("Fetch popular movies URL is not correct.") }
        
        let request = URLRequest(url: url)
        
        return firstly {
            URLSession.shared.dataTask(.promise, with: request)
        }.compactMap {
            return try JSONDecoder().decode(MovieList.self, from: $0.data)
        }
    }
}
