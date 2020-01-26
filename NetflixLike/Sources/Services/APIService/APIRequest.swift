//
//  APIRequest.swift
//  NetflixLike
//
//  Created by Quentin Eude on 26/01/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import Foundation

protocol APIRequest: Encodable {
    associatedtype Response: Decodable

    var resourceName: String { get }
}
