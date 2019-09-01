//
//  SearchListUseCase.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/07/29.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import Foundation

protocol SearchListUseCaseInterface {
    /// Githubrepositoryのリストデータ
    var repositoryList: [Repository] { get }
    /// データ更新の通先
    var delegate: SearchListUseCaseDelegate? { get set }
    /// 検索クエリをアップデートする
    func update(searchQuery: String)
    /// ローディングのフッターが表示されたことを通知する
    func showLoadingFooter()
}

protocol SearchListUseCaseDelegate: class {
    /// データ更新された場合に通知される
    func searchListUseCase(_ useCase: SearchListUseCaseInterface, didLoad repositoryList: [Repository], isError: Bool, isStalled: Bool)
    /// 追加データがあるときに通知される、追加データがないならisStalledがtrue
    func searchListUseCase(_ useCase: SearchListUseCaseInterface, didUpdate repositoryList: [Repository], isStalled: Bool)
}

final class SearchListUseCase: SearchListUseCaseInterface {
    
    var repositoryList: [Repository] {
        repository.repositories
    }
    
    var hasNextURL: Bool {
        return repository.nextURL != nil
    }
    
    weak var delegate: SearchListUseCaseDelegate?
    
    private let repository: SearchRepositoryInterface
    
    init(repository: SearchRepositoryInterface = SearchRepository()) {
        self.repository = repository
    }
    
    func update(searchQuery: String) {
        repository.reload(with: searchQuery) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure:
                self.delegate?.searchListUseCase(self, didLoad: [], isError: true, isStalled: !self.hasNextURL)
            case .success:
                self.delegate?.searchListUseCase(self, didLoad: self.repositoryList, isError: false, isStalled: !self.hasNextURL)
            }
        }
    }
    
    private func loadNext() {
        repository.loadNext { [weak self] _ in
            guard let self = self else { return }
            self.delegate?.searchListUseCase(self, didUpdate: self.repositoryList, isStalled: !self.hasNextURL)
        }
    }
    
    func showLoadingFooter() {
        guard hasNextURL else {
            delegate?.searchListUseCase(self, didUpdate: self.repositoryList, isStalled: true)
            return
        }
        loadNext()
    }
}
