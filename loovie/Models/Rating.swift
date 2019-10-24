//
//  Rating.swift
//  loovie
//
//  Created by tunay alver on 24.10.2019.
//  Copyright © 2019 tunay alver. All rights reserved.
//

import Foundation

class Rating: Codable {

    var source: String!
    var value: String!
    
    enum CodingKeys: String, CodingKey {
        case source      = "Source"
        case value       = "Value"
    }
    
}
