//
//  SearchRepository.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/07/29.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import Foundation
import Combine

protocol SearchRepositoryProtocol {
    /**
     * repositoryのデータ取得を行う
     * 追加読み込みできるURLを指定しない場合はデフォルトのURLが適用される
    **/
    func load(with query: String?, url: URL?) -> PassthroughSubject<(result: [Repository], nextURL: URL?), Error>
}

struct SearchRepository: SearchRepositoryProtocol {
    
    private let requestClient: SearchRequestClientProtocol
    let sort: SearchSortPattern
    
    init(requestClient: SearchRequestClientProtocol = SearchRequestClient(),
        sortPattern: SearchSortPattern = .stars) {
        self.requestClient = requestClient
        self.sort = sortPattern
    }
    
    func load(with query: String?, url: URL?) -> PassthroughSubject<(result: [Repository], nextURL: URL?), Error> {
        let subject = PassthroughSubject<(result: [Repository], nextURL: URL?), Error>()
        requestClient.request(url: url, sort: sort, query: query) { result, response in
            switch result {
            case .success(let repositories):
                subject.send((repositories.items.map { $0.converted }, response?.nextURL))
                subject.send(completion: .finished)
            case .failure(let error):
                subject.send(completion: .failure(error))
            }
        }
        return subject
    }
}
