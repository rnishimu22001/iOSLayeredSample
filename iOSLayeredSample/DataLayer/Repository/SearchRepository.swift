//
//  SearchRepository.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/07/29.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import Foundation

protocol SearchRepositoryProtocol {
    /// Githubリポジトリのデータリスト
    var repositories: [Repository] { get }
    var nextURL: URL? { get }
    var error: Error? { get }
    /**
     * すべてのプロパティをリセットして、1からデータ取得を行う
     * 追加読み込みできるURLがある場合はnextURLの情報が更新される
    **/
    func reload(with query: String,
                completion: @escaping ((Result<Void, Error>) -> Void))
    /**
     * 保持しているnextURLを利用してリクエストを実行する
     * 新規取得したRepositoryデータはrepositoresの配列に追加される
     * 追加読み込みできるURLがある場合はnextURLの情報が更新される
    **/
    func loadNext(with completion: @escaping ((Result<Void, Error>) -> Void))
}

final class SearchRepository: SearchRepositoryProtocol {
    
    private(set) var repositories: [Repository] = []
    private(set) var error: Error?
    private var responseHeader: GitHubAPIResponseHeader?
    
    var nextURL: URL? {
        return self.responseHeader?.nextURL
    }
    
    let requestClient: SearchRequestClientProtocol
    let sort: SearchSortPattern
    
    init(requestClient: SearchRequestClientProtocol = SearchRequestClient(),
        sortPattern: SearchSortPattern = .stars) {
        self.requestClient = requestClient
        self.sort = sortPattern
    }
    
    func reload(with query: String,
                completion: @escaping ((Result<Void, Error>) -> Void)) {
        
        self.repositories = []
        self.error = nil
        self.responseHeader = nil
        requestClient.request(url: nil, sort: sort, query: query) { [weak self] result, response in
            self?.responseHeader = response
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
        self.responseHeader = nil
        requestClient.request(url: self.nextURL, sort: nil, query: nil) { [weak self] result, response in
            self?.responseHeader = response
            switch result {
            case .success(let repositories):
                self?.repositories = repositories.items
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
