//
//  HTTPTask.swift
//  ModernNetwork
//
//  Created by Xi Chen on 09.01.20.
//  Copyright © 2020 Xi Chen. All rights reserved.
//

import Foundation

public enum HTTPTask {
    case request
    case requestWith(payload: Parameters, encoding: ParameterEncoding)
}

