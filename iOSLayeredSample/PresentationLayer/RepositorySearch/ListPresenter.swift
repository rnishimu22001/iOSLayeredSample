//
//  SearchListViewModel.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/07/27.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import UIKit
import Foundation

protocol ListDataSourceProtocol: UITableViewDelegate, UITableViewDataSource {
    /// ユーザーデータ
    var contentsList: [TableViewDisplayable] { get set }
    
    var delegate: ListDataSourceDelegate? { get set }
    /// tableViewにセルを登録する
    func register(in tableView: UITableView)
}

protocol ListDataSourceDelegate: class {
    func listDataSource(_ dataSource: ListDataSourceProtocol, willDisplayLoading cell: UITableViewCell)
    func listDataSource(_ dataSource: ListDataSourceProtocol, didSelectRepositoryListAt index: Int)
}

final class ListDataSource: NSObject, UITableViewDelegate, UITableViewDataSource, ListDataSourceProtocol {
    
    enum Sections: Int, CaseIterable {
        case repositoryList
    }
    
    var contentsList: [TableViewDisplayable] = []
    weak var delegate: ListDataSourceDelegate?
    
    func register(in tableView: UITableView) {
        tableView.register(RepositoryTableViewCell.nib, forCellReuseIdentifier: RepositoryDisplayData.tableViewCellClass.className)
        tableView.register(LoadingCell.nib, forCellReuseIdentifier: LoadingDisplayData.tableViewCellClass.className)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Sections.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = Sections(rawValue: section) else { return 0 }
        switch section {
        case .repositoryList:
            return contentsList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Sections(rawValue: indexPath.section) else { return UITableViewCell() }
        switch section {
        case .repositoryList:
            guard let cell = repositoryListSection(tableView, cellForRowAt: indexPath) else {
                break
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let section = Sections(rawValue: indexPath.section) else { return 0 }
        switch section {
        case .repositoryList:
            break
        }
        guard contentsList.indices.contains(indexPath.row) else { return 0 }
        switch contentsList[indexPath.row] {
        case is RepositoryDisplayData:
            return 100
        case is LoadingDisplayData:
            return 80
        default:
            return 0
        }
    }
    
    func repositoryListSection(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell? {
        guard contentsList.indices.contains(indexPath.row) else {
            return nil
        }
        let data = contentsList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: type(of: data).tableViewCellClass.className, for: indexPath)
        
        switch cell {
        case let repositoryCell as RepositoryTableViewCellProtocol:
            guard let repository = data as? RepositoryDisplayData else {
                break
            }
            repositoryCell.setup(with: repository)
        case let loadingCell as LoadingCell:
            loadingCell.indicator.startAnimating()
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        switch cell {
        case is LoadingCell:
            self.delegate?.listDataSource(self, willDisplayLoading: cell)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch Sections(rawValue: indexPath.section) {
        case .none:
            return
        case .some(.repositoryList):
            self.delegate?.listDataSource(self, didSelectRepositoryListAt: indexPath.row)
        }
    }
}
