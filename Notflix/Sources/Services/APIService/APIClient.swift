//
//  APIClient.swift
//  Notflix
//
//  Created by Quentin Eude on 26/01/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import Foundation
import Combine

public class APIClient {
    private let publicKey: String
    private static let baseUrl: URL? = URL(string: "https://api.themoviedb.org/3/")
    static let baseImageStringUrl: String = "https://image.tmdb.org/t/p/w500"
    private let session: URLSession
    private var cancellable: AnyCancellable?

    init(publicKey: String = "3b426104ae068b7e3222b4d000d29bb5",
         session: URLSession = .shared) {
        self.publicKey = publicKey
        self.session = session
    }

    func send<X>(_ request: APIRequest<X>) -> AnyPublisher<X, Error> {
        guard let endpoint = self.endpoint(for: request) else {
            fatalError("should have an URL here")
        }

        return session
            .dataTaskPublisher(for: URLRequest(url: endpoint))
            .tryMap { try self.validate($0.data, $0.response) }
            .decode(type: X.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    private func validate(_ data: Data, _ response: URLResponse) throws -> Data {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        guard (200..<300).contains(httpResponse.statusCode) else {
            throw APIError.statusCode
        }
        return data
    }

    private func endpoint<X>(for request: APIRequest<X>) -> URL? {
        guard let baseUrl = URL(string: request.path, relativeTo: APIClient.baseUrl) else {
            fatalError("Bad resourceName: \(request.path)")
        }

        var components = URLComponents(url: baseUrl, resolvingAgainstBaseURL: true)!

        let commonQueryItems = [
            URLQueryItem(name: "api_key", value: publicKey)
        ]

        var customQueryItems: [URLQueryItem] = []

        request.parameters?.forEach { (key, value) in
            customQueryItems.append(URLQueryItem(name: key, value: value))
        }

        components.queryItems = commonQueryItems + customQueryItems

        return components.url
    }
}
