//
//  RepositoryDisplayable.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/08/17.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import UIKit

struct RepositoryDisplayData: RepositoryDisplayable, Equatable {
    
    let stars: String
    let starColor: UIColor
    let name: String
    let descpription: String
    let id: Int
    
    init(from repository: Repository) {
        name = repository.fullName
        descpription = repository.itemDescription
        stars = repository.stargazersCount.description
        if repository.stargazersCount > 50000 {
            starColor = .red
        } else {
            starColor = .lightGray
        }
        id = repository.id
    }
}

protocol RepositoryDisplayable: Displayable {
    var id: Int { get }
    var stars: String { get }
    var starColor: UIColor { get }
    var name: String { get }
    var descpription: String { get }
}

extension RepositoryDisplayData {
    static var tableViewCellClass: UITableViewCell.Type {
        return RepositoryTableViewCell.self
    }
}
