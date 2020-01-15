//
//  Parameters.swift
//  ModernNetwork
//
//  Created by Xi Chen on 09.01.20.
//  Copyright © 2020 Xi Chen. All rights reserved.
//

import Foundation

public typealias Parameters = [String: Any]

public enum ParameterEncoding {
    case URLEncoding
    case JSONEncoding
}

public protocol ParameterEncoder {
    static func encode(request: URLRequest, with parameters: Parameters) throws -> URLRequest
}

