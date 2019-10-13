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
    case unknown, urlError(url: String), apiError(reason: String)

    var errorDescription: String? {
        switch self {
        case .unknown:
            return "Unknown error"
        case .urlError(let url):
            return "The following url is not reachable : \(url)"
        case .apiError(let reason):
            return reason
        }
    }
}

class APIService {
    private let apiKey = "3b426104ae068b7e3222b4d000d29bb5"
    private let baseUrl = URL(string: "https://api.themoviedb.org/3/")
    private let baseImageUrl = "https://image.tmdb.org/t/p/original"
    
    func fetchImage(imageUrl: String) -> Promise<Data> {
        guard let url = URL(string: "\(baseImageUrl)\(imageUrl)") else { return Promise(error: APIError.urlError(url: imageUrl)) }
        
        let request = URLRequest(url: url)
        
        return firstly {
            return URLSession.shared.dataTask(.promise, with: request)
        }.compactMap { data, _ -> Data in
            return data
        }
    }
    
    func fetchPopularMovies(page: Int = 1) -> Promise<MovieList> {
        guard var urlComponents = URLComponents(string: "https://api.themoviedb.org/3/movie/popular") else { return Promise<MovieList>(error: APIError.urlError(url: "/movie/popular")) }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "page", value: String(page))
        ]
        
        guard let url = urlComponents.url else { return Promise<MovieList>(error: APIError.urlError(url: "/movie/popular"))}
        
        let request = URLRequest(url: url)
        
        return firstly {
            URLSession.shared.dataTask(.promise, with: request)
        }.compactMap {
            return try JSONDecoder().decode(MovieList.self, from: $0.data)
        }
    }
}
