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
    /// ローディングのフッターの表示を通知
    func nextContentsLoad()
    /// リスト内にあるリポジトリの値を返す
    func repositoryInList(at index: Int) -> RepositoryDisplayData?
}

final class SearchListViewModel: SearchListViewModelProtocol {
    
    let status: CurrentValueSubject<ContentsStatus, Never> = .init(.initalized)
    let contents: CurrentValueSubject<[TableViewDisplayable], Never> = .init([])
    private(set) var useCase: SearchListUseCaseProtocol
    private(set) var isNextContentsLoading: Bool = false
    
    init(useCase: SearchListUseCaseProtocol = SearchListUseCase()) {
        self.useCase = useCase
        self.useCase.delegate = self
    }
    
    func update(searchQuery: String?) {
        guard let query = searchQuery, !query.isEmpty else { return }
        status.value = .loading
        useCase.update(searchQuery: query)
    }
    
    func nextContentsLoad() {
        guard let loading = contents.value.last as? LoadingDisplayData,
            let url = loading.nextLink else { return }
        isNextContentsLoading = true
        useCase.load(next: url)
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

extension SearchListViewModel: SearchListUseCaseDelegate {
    func searchListUseCase(_ useCase: SearchListUseCaseProtocol, didLoad repositoryList: [Repository], isError: Bool, nextURL: URL?) {
        guard !isError else {
            status.value = .error
            return
        }
        contents.value = converting(from: repositoryList, nextURL: nextURL)
        status.value = .browsable
    }
    
    func searchListUseCase(_ useCase: SearchListUseCaseProtocol, shouldAdditional repositoryList: [Repository], nextURL: URL?) {
        var filterd = contents.value.filter { !($0 is LoadingDisplayData) }
        isNextContentsLoading = false
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
