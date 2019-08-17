//
//  RepositorySearchListViewController.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/07/27.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import UIKit

final class RepositorySearchListViewController: UIViewController {
    
    var presenter: RepositorySearchListPresenterProtocol!
    var viewModel: RepositorySearchListViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = RepositorySearchListPresenter(parentView: self.view)
        presenter.delegate = self
        viewModel = RepositorySearchListViewModel()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController?.searchBar.delegate = self
        navigationItem.hidesSearchBarWhenScrolling = true
        viewModel.delegate = self
    }
}

extension RepositorySearchListViewController: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        guard let text = searchBar.text,
            !text.isEmpty else {
                return
        }
        viewModel.update(searchQuery: text)
    }
}

extension RepositorySearchListViewController: RepositorySearchListViewModelDelegate {
    
    func repositorySearchListViewModel(_ viewModel: RepositorySearchListViewModelProtocol, shouldShow status: ContentsStatus, didLoad contents: [Displayable]) {
        presenter.reload(status: status, contentsList: contents)
    }
    
    func repositorySearchListViewModel(_ viewModel: RepositorySearchListViewModelProtocol, didUpdate contents: [Displayable]) {
        presenter.update(contentsList: contents)
    }
}

extension RepositorySearchListViewController: RepositorySearchListPresenterDelegate {
    func repositorySearchListPresenter(_ presenter: RepositorySearchListPresenterProtocol, willDisplayLoading cell: UITableViewCell) {
        self.viewModel.showLoadingFooter()
    }
}
