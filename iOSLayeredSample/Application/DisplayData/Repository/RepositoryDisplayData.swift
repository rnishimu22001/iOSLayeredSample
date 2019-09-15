//
//  DisplayData.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/08/17.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import UIKit

struct RepositoryDisplayData: TableViewDisplayable {
    
    let starCount: String
    let starColor: StarColor
    let name: String
    let descpription: String
    
    init(from repository: Repository) {
        name = repository.fullName
        descpription = repository.description ?? ""
        starCount = repository.starCount.description
        starColor = StarColor(with: repository.starCount)
    }
}

extension RepositoryDisplayData {
    static var tableViewCellClass: UITableViewCell.Type {
        return RepositoryTableViewCell.self
    }
}
