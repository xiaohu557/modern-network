//
//  ServiceError.swift
//  ModernNetwork
//
//  Created by Xi Chen on 09.01.20.
//  Copyright © 2020 Xi Chen. All rights reserved.
//

import Foundation

public enum NetworkError: Error {
    case serviceUnavailable
    case badResponse
    case missingURL
    case encodingFailed
    case unauthorized
    case general(description: String)
}

extension NetworkError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .serviceUnavailable: return "Service unavailable."
        case .badResponse: return "Response seems to be wrong."
        case .missingURL: return "URL missing in the request."
        case .encodingFailed: return "Parameter encoding failed."
        case .unauthorized: return "Authentication required."
        case .general(let description): return description
        }
    }
}
