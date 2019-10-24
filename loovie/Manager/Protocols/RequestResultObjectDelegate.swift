//
//  RequestResultObjectDelegate.swift
//  loovie
//
//  Created by tunay alver on 24.10.2019.
//  Copyright © 2019 tunay alver. All rights reserved.
//

protocol RequestResultObjectDelegate: RequestDelegate {
    
    associatedtype ResultObjectType: Codable
    
    func didSuccess(_ result: DetailResponse)
    
}

extension RequestResultObjectDelegate {
    
    func request(success: @escaping RequestManager.ObjectClosure<ResultObjectType>, failure: @escaping RequestManager.ErrorClosure) {
        RequestManager.request(self, success: { (result: DetailResponse) in
            self.didSuccess(result)
            success(result)
        }) { (error) in
            self.didError(error)
            failure(error)
        }
    }
    
    func didSuccess(_ result: DetailResponse) {}
    
}
