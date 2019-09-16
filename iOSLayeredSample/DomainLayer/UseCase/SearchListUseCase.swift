//
//  SearchListUseCase.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/07/29.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import Foundation
import Combine

protocol SearchListUseCaseProtocol {
    /// 検索クエリをアップデートする
    func update(searchQuery: String) -> PassthroughSubject<(result: [Repository], nextURL: URL?), Error>
    /// 指定された次のページのURLのデータを読み込む
    func load(next url: URL) -> PassthroughSubject<(result: [Repository], nextURL: URL?), Error>
}

final class SearchListUseCase: SearchListUseCaseProtocol {
    
    private let repository: SearchRepositoryProtocol
    
    init(repository: SearchRepositoryProtocol = SearchRepository()) {
        self.repository = repository
    }
    
    func update(searchQuery: String) -> PassthroughSubject<(result: [Repository], nextURL: URL?), Error> {
        return repository.load(with: searchQuery, url: nil)
    }
    
    func load(next url: URL) -> PassthroughSubject<(result: [Repository], nextURL: URL?), Error> {
         return repository.load(with: nil, url: url)
    }
}
