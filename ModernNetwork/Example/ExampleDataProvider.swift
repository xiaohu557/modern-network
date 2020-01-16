//
//  ExampleDataProvider.swift
//  ModernNetwork
//
//  Created by Xi Chen on 16.01.20.
//  Copyright © 2020 Xi Chen. All rights reserved.
//

import Foundation

protocol GithubDataProviderType {
    var hottestRepos: [Repo]? { get }
    var error: NetworkError? { get }
    func getHottestRepos(completion: @escaping (Result<[Repo], NetworkError>) -> Void)
}

class DataProvider {
    let githubService = ServiceProvider<GitHubService>()

    var hottestRepos: [Repo]? // TODO: Transform to observable
    var error: NetworkError? // TODO: Transform to observable

    init() {
        getHottestRepos { [weak self] result in
            switch result {
            case .success(let repos):
                self?.hottestRepos = repos
            case .failure(let error):
                self?.error = error
            }
        }
    }

    func getHottestRepos(completion: @escaping (Result<[Repo], NetworkError>) -> Void) {
        let _ = githubService.request(.hottestRepositories(count: 2)) { result in

            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                do {
                    let repos = try JSONDecoder().decode([Repo].self, from: data)
                    completion(.success(repos))
                } catch {
                    completion(.failure(.decodingFailed))
                }
            }
        }
    }
}
