//
//  BaseResponse.swift
//  loovie
//
//  Created by tunay alver on 24.10.2019.
//  Copyright © 2019 tunay alver. All rights reserved.
//

import Foundation

class BaseResponse: Codable {
    
    var title: String!
    var year: String!
    var imdbID: String!
    var type: String!
    var poster: String!
    
    enum CodingKeys: String, CodingKey {
        case title    = "Title"
        case year     = "Year"
        case imdbID   = "imdbID"
        case type     = "Type"
        case poster   = "Poster"
    }
    
}
