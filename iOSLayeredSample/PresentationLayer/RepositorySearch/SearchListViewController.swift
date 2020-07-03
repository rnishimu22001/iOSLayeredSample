//
//  SearchListViewController.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/07/27.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import SwiftUI
import UIKit
import Combine

final class SearchListViewController: UIViewController {
    
    var searchListView: SearchListViewProtocol!
    var viewModel: SearchListViewModelProtocol = SearchListViewModel()
    let delegateProxy: UISearchBarDelegateProxyProtocol =  UISearchBarDelegateProxy()
    lazy var navigator: Navigator = {
        UINavigatorImplementation(navigation: self.navigationController)
    }()
    private var cancellables: [AnyCancellable] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchListView = SearchListView(parentView: self.view)
        searchListView.delegate = self
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
        let showLoadingFooter = searchListView.showLoadingFooter.sink { [weak self] in
            self?.viewModel.loadNextContents()
        }
        let repositoryUpdate = viewModel.contents.sink { [weak self] contents in
            self?.searchListView.update(contentsList: contents)
        }
        let statusUpdate = viewModel.status.sink { [weak self] status in
            self?.searchListView.change(status: status)
        }
        cancellables.append(textDidEndEditing)
        cancellables.append(showLoadingFooter)
        cancellables.append(repositoryUpdate)
        cancellables.append(statusUpdate)
    }
}

extension SearchListViewController: SearchListViewDelegate {
    
    func searchListView(_ view: SearchListViewProtocol, didSelectRepositoryListAt index: Int) {
        guard let repository = viewModel.repositoryInList(at: index) else {
            return
        }
        let viewController = UIHostingController(rootView: DetailView(repositoryName: repository.name))
        navigator.push(viewControler: viewController)
    }
}
