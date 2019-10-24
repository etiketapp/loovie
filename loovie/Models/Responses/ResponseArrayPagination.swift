//
//  ResponseArrayPagination.swift
//  loovie
//
//  Created by tunay alver on 24.10.2019.
//  Copyright © 2019 tunay alver. All rights reserved.
//

import Foundation

class ResponseArrayPagination<T: Codable>: BaseResponse {
    
    var search: [T]?
    var totalResults: String!
    var Response: String!
    
    enum ResponseArrayCodingKeys: String, CodingKey {
        case Search
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ResponseArrayCodingKeys.self)
        search = try container.decode([T].self, forKey: .Search)
        try super.init(from: decoder)
    }
    
}
