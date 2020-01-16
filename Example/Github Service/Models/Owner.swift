//
//  Owner.swift
//  ModernNetwork
//
//  Created by Xi Chen on 16.01.20.
//  Copyright © 2020 Xi Chen. All rights reserved.
//

import Foundation

struct Owner: Decodable {
    let loginName: String
    let id: Int
    let avatarUrl: String
    let httpUrl: String
    let type: String
}

extension Owner {
    enum CodingKeys: String, CodingKey {
        case loginName = "login"
        case id = "id"
        case avatarUrl = "avatar_url"
        case httpUrl = "url"
        case type = "type"
    }
}
