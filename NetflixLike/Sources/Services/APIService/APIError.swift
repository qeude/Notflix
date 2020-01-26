//
//  APIError.swift
//  NetflixLike
//
//  Created by Quentin Eude on 26/01/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

public enum APIError: Error {
    case encoding
    case decoding
    case server(message: String)
    case invalidUrl
}
