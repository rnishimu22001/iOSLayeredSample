//
//  SearchListView.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/07/27.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import UIKit
import Combine

protocol SearchListViewProtocol {
    var showLoadingFooter: PassthroughSubject<Void, Never> { get }
    var delegate: SearchListViewDelegate? { get set }
    func change(status: ContentsStatus)
    func update(contentsList: [TableViewDisplayable])
}

protocol SearchListViewDelegate: class {
    func searchListView(_ view: SearchListViewProtocol, didSelectRepositoryListAt index: Int)
}

final class SearchListView: NSObject, SearchListViewProtocol {
    
    let showLoadingFooter: PassthroughSubject<Void, Never> = PassthroughSubject()
    @IBOutlet weak var initalizedView: UIView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var tableView: UITableView!
    weak var delegate: SearchListViewDelegate?
    private(set) var listDataSource: ListDataSourceProtocol
    
    required init(parentView: UIView, dataSource: ListDataSourceProtocol = ListDataSource()) {
        self.listDataSource = dataSource
        super.init()
        Bundle.main.loadNibNamed(type(of: self).className, owner: self, options: nil)
        self.listDataSource.delegate = self
        parentView.addSubview(view)
        tableView.delegate = dataSource
        tableView.dataSource = dataSource
        self.listDataSource.register(in: tableView)
    }
    
    func change(status: ContentsStatus) {
        let change = { [weak self] in
            switch status {
            case .browsable:
                self?.tableView.isHidden = false
                self?.errorView.isHidden = true
                self?.loadingView.isHidden = true
                self?.initalizedView.isHidden = true
                break
            case .error:
                self?.tableView.isHidden = true
                self?.errorView.isHidden = false
                self?.loadingView.isHidden = true
                self?.initalizedView.isHidden = true
                return
            case .loading:
                self?.tableView.isHidden = true
                self?.errorView.isHidden = true
                self?.loadingView.isHidden = false
                self?.initalizedView.isHidden = true
                return
            case .initalized:
                self?.tableView.isHidden = true
                self?.errorView.isHidden = true
                self?.loadingView.isHidden = true
                self?.initalizedView.isHidden = false
                return
            }
        }
        DispatchQueue.asyncAtMain {
            change()
        }
    }
    
    func update(contentsList: [TableViewDisplayable]) {
        listDataSource.contentsList = contentsList
        self.reloadList()
    }
    
    private func reloadList() {
        DispatchQueue.asyncAtMain { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension SearchListView: ListDataSourceDelegate {
    func listDataSource(_ dataSource: ListDataSourceProtocol, willDisplayLoading cell: UITableViewCell) {
        showLoadingFooter.send()
    }
    func listDataSource(_ dataSource: ListDataSourceProtocol, didSelectRepositoryListAt index: Int) {
        self.delegate?.searchListView(self, didSelectRepositoryListAt: index)
    }
}
