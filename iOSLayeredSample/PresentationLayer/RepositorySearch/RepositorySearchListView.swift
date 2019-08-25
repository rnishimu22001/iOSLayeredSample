//
//  RepositorySearchListPresenter.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/07/27.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import UIKit
import Combine

protocol RepositorySearchListViewProtocol {
    init(parentView: UIView, listPresenter: RepositoryListViewProtocol)
    var showLoadingFooter: PassthroughSubject<Void, Never> { get }
    var delegate: RepositorySearchListViewDelegate? { get set }
    func change(status: ContentsStatus)
    func update(contentsList: [TableViewDisplayable])
}

protocol RepositorySearchListViewDelegate: class {
    func repositorySearchListView(_ view: RepositorySearchListViewProtocol, didSelectRepositoryListAt index: Int)
}

final class RepositorySearchListView: NSObject, RepositorySearchListViewProtocol {
    
    let showLoadingFooter: PassthroughSubject<Void, Never> = PassthroughSubject()
    @IBOutlet weak var initalizedView: UIView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var tableView: UITableView!
    weak var delegate: RepositorySearchListViewDelegate?
    private(set) var listPresenter: RepositoryListViewProtocol
    
    required init(parentView: UIView, listPresenter: RepositoryListViewProtocol = RepositoryListPresenter()) {
        self.listPresenter = listPresenter
        super.init()
        Bundle.main.loadNibNamed(type(of: self).className, owner: self, options: nil)
        self.listPresenter.delegate = self
        parentView.addSubview(view)
        tableView.delegate = listPresenter
        tableView.dataSource = listPresenter
        self.listPresenter.register(in: tableView)
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
        listPresenter.contentsList = contentsList
        self.reloadList()
    }
    
    private func reloadList() {
        DispatchQueue.asyncAtMain { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension RepositorySearchListView: RepositoryListViewDelegate {
    func repositoryListView(_ view: RepositoryListViewProtocol, willDisplayLoading cell: UITableViewCell) {
        showLoadingFooter.send()
    }
    func repositoryListView(_ view: RepositoryListViewProtocol, didSelectRepositoryListAt index: Int) {
        self.delegate?.repositorySearchListView(self, didSelectRepositoryListAt: index)
    }
}
