//
//  ExampleService.swift
//  ModernNetwork
//
//  Created by Xi Chen on 16.01.20.
//  Copyright © 2020 Xi Chen. All rights reserved.
//

import Foundation

enum GitHubService {
    case hottestRepositories(count: Int)
}

extension GitHubService: EndpointType {
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }

    var path: String {
        switch self {
        case .hottestRepositories:
            return "/search/repositories"
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .hottestRepositories:
            return .get
        }
    }

    var task: HTTPTask {
        switch self {
        case .hottestRepositories(let count):
            let params = ["sort": "stars",
                          "order": "desc",
                          "q": "created:>2019-01-01",
                          "page": "1",
                          "per_page": "\(count)"]
            return .requestWith(payload: params, encoding: .URLEncoding)
        }
    }

    var headers: HTTPHeaders? {
        return ["Content-type": "application/json"]
    }
}
