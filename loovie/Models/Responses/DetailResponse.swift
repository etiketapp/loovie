//
//  DetailResponse.swift
//  loovie
//
//  Created by tunay alver on 24.10.2019.
//  Copyright © 2019 tunay alver. All rights reserved.
//

import Foundation

class DetailResponse: Codable {
    
    var title: String!
    var released: String!
    var director: String!
    var plot: String!
    var awards: String!
    var poster: String!
    var boxOffice: String!
    var ratings: [Rating]!
    
    enum CodingKeys: String, CodingKey {
        case title       = "Title"
        case released    = "Released"
        case director    = "Director"
        case plot        = "Plot"
        case awards      = "Awards"
        case poster      = "Poster"
        case boxOffice   = "BoxOffice"
        case ratings     = "Ratings"
    }
    
}
