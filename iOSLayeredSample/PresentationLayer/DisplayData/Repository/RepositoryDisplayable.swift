//
//  RepositoryDisplayable.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/08/17.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import UIKit

struct RepositoryDisplayData: RepositoryDisplayable {
    
    let starCount: String
    let starColor: StarColor
    let name: String
    let descpription: String
    let id: Int
    
    init(from repository: Repository) {
        name = repository.fullName
        descpription = repository.itemDescription
        starCount = repository.stargazersCount.description
        starColor = StarColor(with: repository.stargazersCount)
        id = repository.id
    }
}

protocol RepositoryDisplayable: TableViewDisplayable {
    var id: Int { get }
    var starCount: String { get }
    var starColor: StarColor { get }
    var name: String { get }
    var descpription: String { get }
}

extension RepositoryDisplayData {
    static var tableViewCellClass: UITableViewCell.Type {
        return RepositoryTableViewCell.self
    }
}
