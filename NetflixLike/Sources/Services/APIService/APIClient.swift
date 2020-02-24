//
//  APIClient.swift
//  NetflixLike
//
//  Created by Quentin Eude on 26/01/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import Foundation
import Combine

typealias CombineResultCallback<Value> = AnyPublisher<Value, Error>

public class APIClient {
    private let publicKey: String
    private let baseUrl: URL?
    private let session: URLSession
    private var cancellable: AnyCancellable?

    init(publicKey: String = "3b426104ae068b7e3222b4d000d29bb5",
         baseUrl: URL? = URL(string: "https://api.themoviedb.org/3/"),
         session: URLSession = .shared) {
        self.publicKey = publicKey
        self.baseUrl = baseUrl
        self.session = session
    }

    func send<T: APIRequest>(_ request: T) -> CombineResultCallback<T.Response> {
        guard let endpoint = self.endpoint(for: request) else {
            fatalError("should have an URL here")
        }

        return session
            .dataTaskPublisher(for: URLRequest(url: endpoint))
            .tryMap { try self.validate($0.data, $0.response) }
            .decode(type: T.Response.self, decoder: JSONDecoder())
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
