//
//  APIService.swift
//  NetflixLike
//
//  Created by Quentin Eude on 07/10/2019.
//  Copyright © 2019 Quentin Eude. All rights reserved.
//

import Foundation
import Combine

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
    
    
    func fetchPopuplarMovies(page: Int = 1, completion: @escaping (MovieList) -> ()) {
        guard var urlComponents = URLComponents(string: "https://api.themoviedb.org/3/movie/popular") else { fatalError("Fetch popular movies URL is not correct.") }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "page", value: String(page))
        ]
        
        guard let url = urlComponents.url else { fatalError("Fetch popular movies URL is not correct.") }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, _, _ in
            guard let data = data else { return }
            print(data)
            do {
                let movies = try JSONDecoder().decode(MovieList.self, from: data)
                DispatchQueue.main.async {
                    completion(movies)
                }
            } catch {
                print("Failed to decode : \(error)")
            }
        }.resume()
    }
}
