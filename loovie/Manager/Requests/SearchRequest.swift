//
//  SearchRequest.swift
//  loovie
//
//  Created by tunay alver on 24.10.2019.
//  Copyright © 2019 tunay alver. All rights reserved.
//

import Alamofire

struct SearchRequest: RequestResultArrayPaginationDelegate {
    
    typealias ResultObjectType = BaseResponse
    
    var path: String = ""
    var method: HTTPMethod = .get
    var parameters: Parameters?
    var appid = "c6f47cc6"
    
    init(searchString: String?, page: Int?) {
        parameters = [:]
        parameters!["s"] = searchString
        parameters!["page"] = page
        parameters!["apikey"] = appid
    }
    
}
