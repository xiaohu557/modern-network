//
//  Error+NetworkError.swift
//  ModernNetwork
//
//  Created by Xi Chen on 15.01.20.
//  Copyright © 2020 Xi Chen. All rights reserved.
//

import Foundation

extension Error {
    public func toNetworkError() -> NetworkError {
        return NetworkError.general(description: self.localizedDescription)
    }
}
