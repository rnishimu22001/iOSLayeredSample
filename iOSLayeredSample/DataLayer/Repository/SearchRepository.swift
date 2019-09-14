//
//  SearchRepository.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/07/29.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import Foundation

protocol SearchRepositoryProtocol {
    /**
     * repositoryのデータ取得を行う
     * 追加読み込みできるURLを指定しない場合はデフォルトのURLが適用される
    **/
    func load(with query: String?,
              url: URL?,
              completion: @escaping ((_ result: Result<[RepositoryData], Error>, _ nextURL: URL?) -> Void))
}

struct SearchRepository: SearchRepositoryProtocol {
    
    private let requestClient: SearchRequestClientProtocol
    let sort: SearchSortPattern
    
    init(requestClient: SearchRequestClientProtocol = SearchRequestClient(),
        sortPattern: SearchSortPattern = .stars) {
        self.requestClient = requestClient
        self.sort = sortPattern
    }
    
    func load(with query: String?,
              url: URL?,
              completion: @escaping ((_ result: Result<[RepositoryData], Error>, _ nextURL: URL?) -> Void)) {
        requestClient.request(url: url, sort: sort, query: query) { result, response in
            switch result {
            case .success(let repositories):
                completion(.success(repositories.items), response?.nextURL)
            case .failure(let error):
                completion(.failure(error), response?.nextURL)
            }
        }
    }
}
