//
//  SearchListUseCase.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/07/29.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import Foundation

protocol SearchListUseCaseProtocol {
    /// データ更新の通先
    var delegate: SearchListUseCaseDelegate? { get set }
    /// 検索クエリをアップデートする
    func update(searchQuery: String)
    /// 次のデータを読み込む
    func load(next url: URL)
}

protocol SearchListUseCaseDelegate: class {
    /// データ更新された場合に通知される
    func searchListUseCase(_ useCase: SearchListUseCaseProtocol, didLoad repositoryList: [Repository], isError: Bool, nextURL: URL?)
    /// 追加データがあるときに通知される、追加データがないならnextURLがnil
    func searchListUseCase(_ useCase: SearchListUseCaseProtocol, shouldAdditional repositoryList: [Repository], nextURL: URL?)
}

final class SearchListUseCase: SearchListUseCaseProtocol {
    
    weak var delegate: SearchListUseCaseDelegate?
    
    private let repository: SearchRepositoryProtocol
    
    init(repository: SearchRepositoryProtocol = SearchRepository()) {
        self.repository = repository
    }
    
    func update(searchQuery: String) {
        repository.load(with: searchQuery, url: nil) { [weak self] result ,nextURL in
            guard let self = self else { return }
            switch result {
            case .failure:
                self.delegate?.searchListUseCase(self, didLoad: [], isError: true, nextURL: nextURL)
            case .success(let repositories):
                self.delegate?.searchListUseCase(self, didLoad: repositories, isError: false, nextURL: nextURL)
            }
        }
    }
    
    func load(next url: URL) {
         repository.load(with: nil, url: url) { [weak self] result ,nextURL in
            guard let self = self else { return }
            switch result {
            case .failure:
                self.delegate?.searchListUseCase(self, shouldAdditional: [], nextURL: nil)
            case .success(let repositories):
                self.delegate?.searchListUseCase(self, shouldAdditional: repositories, nextURL: nextURL)
            }
        }
    }
}
