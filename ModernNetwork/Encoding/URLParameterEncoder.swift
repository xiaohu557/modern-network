//
//  URLParameterEncoder.swift
//  ModernNetwork
//
//  Created by Xi Chen on 09.01.20.
//  Copyright © 2020 Xi Chen. All rights reserved.
//

import Foundation

public struct URLParameterEncoder: ParameterEncoder {

    public static func encode(request: URLRequest, with parameters: Parameters) throws -> URLRequest {
        guard let url = request.url else { throw NetworkError.missingURL }
        
        var newRequest = request

        if var urlComponents = URLComponents(url: url,
                                             resolvingAgainstBaseURL: false) {
            var queryItems = [URLQueryItem]()
            
            for (key, value) in parameters {
                let stringValue = String(describing: value)
                let queryItem = URLQueryItem(name: key, value: stringValue)
                queryItems.append(queryItem)
            }
            
            urlComponents.queryItems = queryItems
            
            newRequest.url = urlComponents.url
        }
        
        newRequest.setValue("application/x-www-form-urlencoded",
                            forHTTPHeaderField: "Content-Type")
        
        return newRequest
    }
}
