//
//  RepositorySearchListPresenter.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/07/27.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import UIKit

protocol RepositorySearchListPresenterProtocol {
    init(parentView: UIView, listPresenter: RepositoryListPresenterProtocol)
    var delegate: RepositorySearchListPresenterDelegate? { get set }
    func reload(status: ContentsStatus, contentsList: [TableViewDisplayable])
    func update(contentsList: [TableViewDisplayable])
}

protocol RepositorySearchListPresenterDelegate: class {
    func repositorySearchListPresenter(_ presenter: RepositorySearchListPresenterProtocol, willDisplayLoading cell: UITableViewCell)
}

final class RepositorySearchListPresenter: NSObject, RepositorySearchListPresenterProtocol {
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var tableView: UITableView!
    weak var delegate: RepositorySearchListPresenterDelegate?
    private(set) var listPresenter: RepositoryListPresenterProtocol
    
    required init(parentView: UIView, listPresenter: RepositoryListPresenterProtocol = RepositoryListPresenter()) {
        self.listPresenter = listPresenter
        super.init()
        Bundle.main.loadNibNamed(type(of: self).className, owner: self, options: nil)
        self.listPresenter.delegate = self
        parentView.addSubview(view)
        tableView.delegate = listPresenter
        tableView.dataSource = listPresenter
        self.listPresenter.register(in: tableView)
    }
    
    func reload(status: ContentsStatus, contentsList: [TableViewDisplayable]) {
        listPresenter.contentsList = contentsList
        reloadView()
    }
    
    func update(contentsList: [TableViewDisplayable]) {
        listPresenter.contentsList = contentsList
        reloadView()
    }
    
    private func reloadView() {
        let reload = { [weak self] in
            self?.tableView.reloadData()
        }
        guard !Thread.isMainThread else {
            reload()
            return
        }
        DispatchQueue.main.async {
            reload()
        }
    }
}

extension RepositorySearchListPresenter: RepositoryListPresenterDelegate {
    func repositoryListPresenter(_ presenter: RepositoryListPresenterProtocol, willDisplayLoading cell: UITableViewCell) {
        self.delegate?.repositorySearchListPresenter(self, willDisplayLoading: cell)
    }
}
