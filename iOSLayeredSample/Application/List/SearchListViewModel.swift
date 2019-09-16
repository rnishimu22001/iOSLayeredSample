//
//  SearchListViewModel.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/07/27.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import Combine
import Foundation

protocol SearchListViewModelProtocol {
    /// 表示状態
    var status: CurrentValueSubject<ContentsStatus, Never> { get }
    /// Githubリポジトリリストのデータ
    var contents: CurrentValueSubject<[TableViewDisplayable], Never> { get }
    /// クエリのアップデート
    func update(searchQuery: String?)
    /// ページングによる次のコンテンツのロード
    func nextContentsLoad()
    /// リスト内にあるリポジトリの値を返す
    func repositoryInList(at index: Int) -> RepositoryDisplayData?
}

final class SearchListViewModel: SearchListViewModelProtocol {
    
    let status: CurrentValueSubject<ContentsStatus, Never> = .init(.initalized)
    let contents: CurrentValueSubject<[TableViewDisplayable], Never> = .init([])
    
    private(set) var useCase: SearchListUseCaseProtocol
    private(set) var currentLoadingCancelable: AnyCancellable?
    
    init(useCase: SearchListUseCaseProtocol = SearchListUseCase()) {
        self.useCase = useCase
    }
    
    func update(searchQuery: String?) {
        guard let query = searchQuery, !query.isEmpty else { return }
        status.value = .loading
        currentLoadingCancelable = useCase.update(searchQuery: query).sink(receiveCompletion: { [weak self] result in
            switch result {
            case .finished:
                self?.status.value = .browsable
            case .failure:
                self?.status.value = .error
            }
        }, receiveValue: { [weak self] contents in
            guard let self = self else { return }
            self.contents.value = self.converting(from: contents.result, nextURL: contents.nextURL)
        })
    }
    
    func nextContentsLoad() {
        guard
            let loading = contents.value.last as? LoadingDisplayData,
            let url = loading.nextLink,
            currentLoadingCancelable == nil else { return }
        
        currentLoadingCancelable = useCase.load(next: url).sink(receiveCompletion: { [weak self] _ in
            self?.currentLoadingCancelable = nil
        }, receiveValue: { [weak self] contents in
            self?.didLoad(additional: contents.result, nextURL: contents.nextURL)
        })
    }
    
    func repositoryInList(at index: Int) -> RepositoryDisplayData? {
        let list = self.contents.value
        guard list.indices.contains(index) else { return nil }
        switch list[index] {
        case let repository as RepositoryDisplayData:
            return repository
        default:
            return nil
        }
    }
}

extension SearchListViewModel {
    
    func didLoad(additional repositoryList: [Repository], nextURL: URL?) {
        var filterd = contents.value.filter { !($0 is LoadingDisplayData) }
        filterd.append(contentsOf: converting(from: repositoryList, nextURL: nextURL))
        contents.value = filterd
    }
    
    func converting(from repositoryList: [Repository], nextURL: URL?) -> [TableViewDisplayable] {
        var contents: [TableViewDisplayable] = []
        contents = repositoryList.map { RepositoryDisplayData(from: $0) }
        if let url = nextURL {
            contents.append(LoadingDisplayData(nextLink: url))
        }
        return contents
    }
}
