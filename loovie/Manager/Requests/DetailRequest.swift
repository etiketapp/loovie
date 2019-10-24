//
//  DetailRequest.swift
//  loovie
//
//  Created by tunay alver on 24.10.2019.
//  Copyright © 2019 tunay alver. All rights reserved.
//

import Alamofire

struct DetailRequest: RequestResultObjectDelegate {
    
    typealias ResultObjectType = DetailResponse
    
    var path: String = ""
    var method: HTTPMethod = .get
    var parameters: Parameters?
    var appid = "c6f47cc6"
    
    init(imdbID: String) {
        parameters = [:]
        parameters!["apikey"] = appid
        parameters!["i"] = imdbID
    }
    
}
