//
//  HTTPMethod.swift
//  ModernNetwork
//
//  Created by Xi Chen on 09.01.20.
//  Copyright © 2020 Xi Chen. All rights reserved.
//

import Foundation

public enum HTTPMethod: String {
    case get
    case post
    case put
    case patch
    case delete
    
    public var upperCasedStringValue: String {
        return self.rawValue.uppercased()
    }
}
