//
//  Repo.swift
//  ModernNetwork
//
//  Created by Xi Chen on 16.01.20.
//  Copyright © 2020 Xi Chen. All rights reserved.
//

import Foundation

struct Repo: Decodable {
    let id: Int
    let name: String
    let fullName: String
    let isPrivate: Bool
    let htmlUrl: String
    let description: String
    let createdAt: Date
    let updatedAt: Date
    let starsCount: Int
    let watchersCount: Int
    var language: String?
    let forksCount: Int
    let openIssuesCount: Int
    let score: Double
    let owner: Owner
}

extension Repo {
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case fullName = "full_name"
        case isPrivate = "private"
        case htmlUrl = "html_url"
        case description = "description"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case starsCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case language = "language"
        case forksCount = "forks_count"
        case openIssuesCount = "open_issues_count"
        case score = "score"
        case owner = "owner"
    }
}
