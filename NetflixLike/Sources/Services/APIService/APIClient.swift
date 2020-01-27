//
//  APIClient.swift
//  NetflixLike
//
//  Created by Quentin Eude on 26/01/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import Foundation

typealias ResultCallback<Value> = (Result<Value, Error>) -> Void

public class APIClient {
    private let publicKey: String
    private let baseUrl: URL?
    private let session: URLSession

    init(publicKey: String = "3b426104ae068b7e3222b4d000d29bb5",
         baseUrl: URL? = URL(string: "https://api.themoviedb.org/3/"),
         session: URLSession = .shared) {
        self.publicKey = publicKey
        self.baseUrl = baseUrl
        self.session = session
    }
    func send<T: APIRequest>(_ request: T, completion: @escaping ResultCallback<T.Response>) {
        guard let endpoint = self.endpoint(for: request) else {
            completion(.failure(APIError.invalidUrl))
            return
        }

        let task = session.dataTask(with: URLRequest(url: endpoint)) { data, _, error in
            if let data = data {
                do {
                    let apiResponse = try JSONDecoder().decode(APIResponse<T.Response>.self, from: data)

                    if let dataResponse = apiResponse.results {
                        completion(.success(dataResponse))
                    } else {
                        completion(.failure(APIError.decoding))
                    }
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }
        task.resume()
    }

    private func endpoint<T: APIRequest>(for request: T) -> URL? {
        guard let baseUrl = URL(string: request.resourceName, relativeTo: baseUrl) else {
            fatalError("Bad resourceName: \(request.resourceName)")
        }

        var components = URLComponents(url: baseUrl, resolvingAgainstBaseURL: true)!

        let commonQueryItems = [
            URLQueryItem(name: "api_key", value: publicKey)
        ]

        let customQueryItems: [URLQueryItem]

        do {
            customQueryItems = try URLQueryItemEncoder.encode(request)
        } catch {
            fatalError("Wrong parameters: \(error)")
        }

        components.queryItems = commonQueryItems + customQueryItems

        return components.url
    }
}
