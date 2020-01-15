//
//  JSONParameterEncoder.swift
//  ModernNetwork
//
//  Created by Xi Chen on 10.01.20.
//  Copyright © 2020 Xi Chen. All rights reserved.
//

import Foundation

public struct JSONParameterEncoder: ParameterEncoder {
    public static func encode(request: URLRequest, with parameters: Parameters) throws -> URLRequest {
        
        var newRequest = request
        
        guard let jsonPayload = try? JSONSerialization.data(
            withJSONObject: parameters,
            options: .prettyPrinted
            ) else {
                throw NetworkError.encodingFailed
        }
        
        newRequest.httpBody = jsonPayload
        
        newRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return newRequest
    }
}
