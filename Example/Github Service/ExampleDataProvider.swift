//
//  ExampleDataProvider.swift
//  ModernNetwork
//
//  Created by Xi Chen on 16.01.20.
//  Copyright © 2020 Xi Chen. All rights reserved.
//

import ModernNetwork

protocol GithubDataProviderType {
    var hottestRepos: Observable<[Repo]> { get }
    var error: Observable<NetworkError?> { get }
    func fetchData()
}

class GithubDataProvider: GithubDataProviderType {
    let githubService = ServiceProvider<GitHubService>()

    let hottestRepos = Observable<[Repo]>([])
    let error = Observable<NetworkError?>(nil)

    func fetchData() {
        getHottestRepos(count: 10) { [weak self] result in
            switch result {
            case .success(let repos):
                self?.hottestRepos.accept(repos)
            case .failure(let error):
                self?.error.accept(error)
            }
        }
    }
}

extension GithubDataProvider {
    private func getHottestRepos(count: Int, completion: @escaping (Result<[Repo], NetworkError>) -> Void) {
        let _ = githubService.request(.hottestRepositories(count: count)) { result in

            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                do {
                    let response = try JSONDecoder().decode(SearchResponse.self,
                                                            from: data)
                    completion(.success(response.items))
                } catch {
                    completion(.failure(.decodingFailed))
                }
            }
        }
    }
}
