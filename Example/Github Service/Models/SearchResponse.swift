//
//  SearchResponse.swift
//  Example
//
//  Created by Xi Chen on 16.01.20.
//  Copyright © 2020 Xi Chen. All rights reserved.
//

import Foundation

struct SearchResponse: Decodable {
    let totalCount: Int
    let hasIncompleteResults: Bool
    let items: [Repo]
}

extension SearchResponse {
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case hasIncompleteResults = "incomplete_results"
        case items = "items"
    }
}
