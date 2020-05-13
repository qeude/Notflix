//
//  APIError.swift
//  Notflix
//
//  Created by Quentin Eude on 26/01/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//
protocol LocalizedError: Error {
    var localizedDescription: String { get }
}
enum APIError: LocalizedError {
    case encoding
    case decoding
    case server(message: String)
    case invalidUrl
    case statusCode
    case invalidResponse

    var localizedDescription: String {
        switch self {
        case .encoding: return "APIError while encoding"
        case .decoding: return "APIError while decoding"
        case .server(let message): return "APIError due to the server with message: \(message)"
        case .invalidUrl: return "APIError invalidUrl"
        case .statusCode: return "APIError status code error"
        case .invalidResponse: return "APIError invalid response"
        }
    }
}
