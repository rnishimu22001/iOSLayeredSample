//
//  RepositorySearchListViewModel.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/07/27.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import Combine

protocol RepositorySearchListViewModelProtocol {
    var status: CurrentValueSubject<ContentsStatus, Never> { get }
    var repositoryList: CurrentValueSubject<[TableViewDisplayable], Never> { get }
    /// クエリのアップデート
    func update(searchQuery: String?)
    /// ローディングのフッターの表示のsubscribe
    func showLoadingFooter()
}

final class RepositorySearchListViewModel: RepositorySearchListViewModelProtocol {
    
    let status: CurrentValueSubject<ContentsStatus, Never> = .init(.initalized)
    let repositoryList: CurrentValueSubject<[TableViewDisplayable], Never> = .init([])
    private(set) var useCase: RepositorySearchListUseCaseProtocol
    
    init(useCase: RepositorySearchListUseCaseProtocol = RepositorySearchListUseCase()) {
        self.useCase = useCase
        self.useCase.delegate = self
    }
    
    func update(searchQuery: String?) {
        guard let query = searchQuery, !query.isEmpty else { return }
        status.value = .loading
        useCase.update(searchQuery: query)
    }
    
    func showLoadingFooter() {
        useCase.showLoadingFooter()
    }
}

extension RepositorySearchListViewModel: RepositorySearchListUseCaseDelegate {
    
    func repositorySearchListUseCase(_ useCase: RepositorySearchListUseCaseProtocol, didLoad repositoryList: [Repository], isError: Bool, isStalled: Bool) {
        guard !isError else {
            status.value = .error
            return
        }
        self.repositoryList.value = (contents(from: repositoryList, isStalled: isStalled))
        status.value = .browsable
    }
    
    func repositorySearchListUseCase(_ useCase: RepositorySearchListUseCaseProtocol, didUpdate repositoryList: [Repository], isStalled: Bool) {
        self.repositoryList.value = (contents(from: repositoryList, isStalled: isStalled))
    }
    
    func contents(from repositoryList: [Repository], isStalled: Bool) -> [TableViewDisplayable] {
        var contents: [TableViewDisplayable] = []
        contents = repositoryList.map { RepositoryDisplayData(from: $0) }
        if !isStalled {
            contents.append(LoadingDisplayable())
        }
        return contents
    }
}
