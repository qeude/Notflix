//
//  APIRequest.swift
//  Notflix
//
//  Created by Quentin Eude on 26/01/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import Foundation

class APIRequest<E: Decodable>: Encodable {
    let path: String
    let parameters: [String: String]?
    init(path: String, parameters: [String: String]? = nil) {
        self.path = path
        self.parameters = parameters
    }
}
