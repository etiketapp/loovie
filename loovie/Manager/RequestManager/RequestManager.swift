//
//  RequestManager.swift
//  loovie
//
//  Created by tunay alver on 24.10.2019.
//  Copyright © 2019 tunay alver. All rights reserved.
//

import Alamofire

class RequestManager {
    
    typealias ErrorClosure = ((ResponseError) -> Void)
    typealias ArrayClosure<T: Codable> = ((ResponseArray<T>) -> Void)
    typealias ObjectClosure<T: Codable> = ((DetailResponse) -> Void)
    typealias ArrayPaginationClosure<T: Codable> = ((ResponseArrayPagination<T>) -> Void)
    
    static let errorCodeConnection = "error.connection"
    static let errorCodeLocal = "error.local"
    static let errorCodeUnknown = "error.unknown"
    
    static var apiUrl: String {
        get {
            return "http://www.omdbapi.com"
        }
    }
    
    private static func createRequest(_ request: RequestDelegate) -> DataRequest {
        print("\n\nRequest Path: \(request.path)")
        print("Request Method: \(request.method.rawValue)")
        print("Request Parameters:")
        print(request.parameters ?? "nil")
        
        let request  = Alamofire.request(apiUrl+request.path, method: request.method, parameters: request.parameters, encoding: URLEncoding.default, headers: nil)
        
        request.validate()
        request.responseData { (response) in
            if let value = response.result.value {
                if let json = String(data: value, encoding: .utf8) {
                    print("Response JSON: \n\(json)")
                }
            }
        }
        return request
    }
    
    //MARK: - Array Request
    static func request<T: Codable>(_ request: RequestDelegate, success: @escaping ArrayClosure<T>, failure: @escaping ErrorClosure) {
        let request = createRequest(request)
        request.responseData { (response) in
            switch response.result {
            case .success:
                let response = ResponseArray<T>.decode(response.result.value!)
                if response != nil {
                    success(response!)
                }else {
//                    success(ResponseError.decode(response.result.value!)!)
                }
            case .failure:
                handleFailure(response: response, failure: failure)
            }
        }
    }
    
    //MARK: - Object Request
    static func request(_ request: RequestDelegate, success: @escaping ObjectClosure<DetailResponse>, failure: @escaping ErrorClosure) {
        let request = createRequest(request)
        request.responseData { (response) in
            switch response.result {
            case .success:
                success(DetailResponse.decode(response.result.value!)!)
            case .failure:
                handleFailure(response: response, failure: failure)
            }
        }
    }
    
    //MARK: - Pagination
    static func request<T: Codable>(_ request: RequestDelegate, success: @escaping ArrayPaginationClosure<T>, failure: @escaping ErrorClosure) {
        let request = createRequest(request)
        request.responseData { (response) in
            let sucess = ResponseArrayPagination<T>.decode(response.result.value!)
            switch response.result {
            case .success:
                if sucess != nil {
                    success(sucess!)
                }else {
                    handleFailure(response: response, failure: failure)
                }
            case .failure:
                handleFailure(response: response, failure: failure)
            }
        }
    }
    
    //MARK: - Handle failure
    private static func handleFailure(response: DataResponse<Data>, failure: @escaping ErrorClosure) {
        if let data = response.data, let serviceError = ResponseError.decode(data) {
            if let json = String(data: data, encoding: .utf8) {
                print("Response JSON: \(json)")
            }
            handleError(statusCode: response.response?.statusCode, localError: nil, serviceError: serviceError, failure: failure)
        } else if let error = response.result.error {
            handleError(statusCode: nil, localError: error, serviceError: nil, failure: failure)
        } else {
            handleError(statusCode: nil, localError: nil, serviceError: nil, failure: failure)
        }
    }
    
    private static func handleError(statusCode: Int?, localError: Error?, serviceError: ResponseError?, failure: @escaping ErrorClosure) {
        if let error = serviceError {
            failure(error)
        } else if let error = localError as? URLError, error.code == .notConnectedToInternet {
            failure(ResponseError(response: errorCodeConnection, error: error.localizedDescription))
        } else if let error = localError {
            failure(ResponseError(response: errorCodeLocal, error: error.localizedDescription))
        } else {
            failure(ResponseError(response: errorCodeUnknown, error: "Unknow Error"))
        }
    }
    
}

