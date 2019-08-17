//
//  RepositorySearchListViewModel.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/07/27.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

protocol RepositorySearchListViewModelProtocol {
    var status: ContentsStatus { get }
    /// データ更新の通先
    var delegate: RepositorySearchListViewModelDelegate? { get set }
    /// クエリがアップデートされた
    func update(searchQuery: String)
    /// ローディングのフッターが表示された時
    func showLoadingFooter()
}

protocol RepositorySearchListViewModelDelegate: class {
    /// データ更新された場合に通知される
    func repositorySearchListViewModel(_ viewModel: RepositorySearchListViewModelProtocol, shouldShow viewType: ContentsStatus, didLoad contents: [TableViewDisplayable])
    /// 追加データがあるときに通知される
    func repositorySearchListViewModel(_ viewModel: RepositorySearchListViewModelProtocol, didUpdate contents: [TableViewDisplayable])
}

final class RepositorySearchListViewModel: RepositorySearchListViewModelProtocol {
    var status: ContentsStatus = .initalized {
        didSet {
            
        }
    }
    var delegate: RepositorySearchListViewModelDelegate?
    private(set) var useCase: RepositorySearchListUseCaseProtocol
    
    init(useCase: RepositorySearchListUseCaseProtocol = RepositorySearchListUseCase()) {
        self.useCase = useCase
        self.useCase.delegate = self
    }
    
    func update(searchQuery: String) {
        status = .loading
        useCase.update(searchQuery: searchQuery)
    }
    
    func showLoadingFooter() {
        useCase.showLoadingFooter()
    }
}

extension RepositorySearchListViewModel: RepositorySearchListUseCaseDelegate {
    
    func repositorySearchListUseCase(_ useCase: RepositorySearchListUseCaseProtocol, didLoad repositoryList: [Repository], isError: Bool, isStalled: Bool) {
        guard !isError else {
            status = .error
            return
        }
        status = .browsable
        delegate?.repositorySearchListViewModel(self, shouldShow: status, didLoad: contents(from: repositoryList, isStalled: isStalled))
    }
    
    func repositorySearchListUseCase(_ useCase: RepositorySearchListUseCaseProtocol, didUpdate repositoryList: [Repository], isStalled: Bool) {
        delegate?.repositorySearchListViewModel(self, didUpdate: contents(from: repositoryList, isStalled: isStalled))
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
