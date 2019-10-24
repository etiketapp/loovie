//
//  RequestResultArrayPaginationDelegate.swift
//  loovie
//
//  Created by tunay alver on 24.10.2019.
//  Copyright © 2019 tunay alver. All rights reserved.
//

import Foundation

protocol RequestResultArrayPaginationDelegate: RequestDelegate {
    
    associatedtype ResultObjectType: Codable
    
    func didSuccess(_ result: ResponseArrayPagination<ResultObjectType>)
    
}

extension RequestResultArrayPaginationDelegate {
    
    func request(success: @escaping RequestManager.ArrayPaginationClosure<ResultObjectType>, failure: @escaping RequestManager.ErrorClosure) {
        RequestManager.request(self, success: { (result: ResponseArrayPagination<ResultObjectType>) in
            self.didSuccess(result)
            success(result)
        }) { (error) in
            self.didError(error)
            failure(error)
        }
    }
    
    func didSuccess(_ result: ResponseArrayPagination<ResultObjectType>) {}
    
}
