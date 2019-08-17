//
//  RepositorySearchRepository.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/07/29.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import Foundation

protocol RepositorySearchRepositoryProtocol {
    var repositories: [Repository] { get }
    var hasNextURL: Bool { get }
    var isError: Bool { get }
    var error: Error? { get }
    
    func reload(with query: String,
                completion: @escaping ((Result<Void, Error>) -> Void))
    func loadNext(with completion: @escaping ((Result<Void, Error>) -> Void))
}

final class RepositorySearchRepository: RepositorySearchRepositoryProtocol {
    
    private(set) var repositories: [Repository] = []
    private(set) var nextURL: String?
    private(set) var error: Error?
    
    let entryPoint = APIURLSetting.repositorySearch
    
    var hasNextURL: Bool {
        return nextURL != nil
    }
    
    var isError: Bool {
        return error != nil
    }
    
    let requestClient: RepositorySearchRequestClientProtocol
    let sort: RepositorySearchSortPattern
    
    init(requestClient: RepositorySearchRequestClientProtocol = RepositorySearchRequestClient(),
        sortPattern: RepositorySearchSortPattern = .stars) {
        self.requestClient = requestClient
        self.sort = sortPattern
    }
    
    func reload(with query: String,
                completion: @escaping ((Result<Void, Error>) -> Void)) {
        
        self.repositories = []
        self.error = nil
        self.nextURL = nil
        requestClient.request(with: entryPoint, sort: sort, query: query) { [weak self] result, response in
            if let header = response?.allHeaderFields {
                let res = GitHubAPIResponseHeader(with: header)
                self?.nextURL = res.nextURL
            }
            switch result {
            case .success(let repositories):
                self?.repositories = repositories.items
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func loadNext(with completion: @escaping ((Result<Void, Error>) -> Void)) {
        
        guard let nextURL = nextURL else {
            completion(.success(()))
            return
        }
        self.error = nil
        self.nextURL = nil
        requestClient.request(nextURL: nextURL) { [weak self] result, response in
            if let header = response?.allHeaderFields {
                let res = GitHubAPIResponseHeader(with: header)
                self?.nextURL = res.nextURL
            }
            switch result {
            case .success(let repositories):
                self?.repositories.append(contentsOf: repositories.items)
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
}
