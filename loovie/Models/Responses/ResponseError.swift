//
//  ResponseError.swift
//  loovie
//
//  Created by tunay alver on 24.10.2019.
//  Copyright © 2019 tunay alver. All rights reserved.
//

import Foundation

struct ResponseError: Codable {
    
    var response: String!
    var error: String!
    
    init() {    }
    
    init(response: String, error: String) {
        self.response = response
        self.error = error
    }
    
    enum CodingKeys: String, CodingKey {
        case response = "Response"
        case error    = "Error"
    }
    
}
