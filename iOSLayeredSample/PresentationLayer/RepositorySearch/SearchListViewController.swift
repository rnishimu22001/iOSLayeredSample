//
//  SearchListViewController.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/07/27.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import UIKit
import Combine

final class SearchListViewController: UIViewController {
    
    var presenter: SearchListPresenterProtocol!
    var viewModel: SearchListViewModelProtocol!
    let delegateProxy: UISearchBarDelegateProxyProtocol =  UISearchBarDelegateProxy()
    private var cancellables: [AnyCancellable] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = SearchListPresenter(parentView: self.view)
        viewModel = SearchListViewModel()
        presenter.delegate = self
        sink()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController?.searchBar.delegate = delegateProxy
        navigationItem.hidesSearchBarWhenScrolling = true
        
    }
    
    private func sink() {
        let textDidEndEditing = delegateProxy.textDidEndEditing.sink { [weak self] query in
            self?.viewModel.update(searchQuery: query)
        }
        let showLoadingFooter = presenter.showLoadingFooter.sink { [weak self] in
            self?.viewModel.showLoadingFooter()
        }
        let repositoryUpdate = viewModel.repositoryList.sink { [weak self] contents in
            self?.presenter.update(contentsList: contents)
        }
        let statusUpdate = viewModel.status.sink { [weak self] status in
            self?.presenter.change(status: status)
        }
        cancellables.append(textDidEndEditing)
        cancellables.append(showLoadingFooter)
        cancellables.append(repositoryUpdate)
        cancellables.append(statusUpdate)
    }
}

extension SearchListViewController: SearchListPresenterDelegate {
    
    func searchListPresenter(_ presenter: SearchListPresenterProtocol, didSelectRepositoryListAt index: Int) {
        guard let repository = viewModel.repositoryInList(at: index) else {
            return
        }
        let viewController = RepositoryDetailViewController()
        viewController.repositoryFullName = repository.name
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
