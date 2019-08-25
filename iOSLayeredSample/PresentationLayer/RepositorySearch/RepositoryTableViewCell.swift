//
//  UserTableViewCell.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/07/27.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import UIKit

protocol RepositoryTableViewCellProtocol {
    func setup(with repository: RepositoryDisplayable)
}

final class RepositoryTableViewCell: UITableViewCell, RepositoryTableViewCellProtocol {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var star: UIImageView!
    @IBOutlet weak var starCount: UILabel!
    
    func setup(with repository: RepositoryDisplayable) {
        name.text = repository.name
        descriptionLabel.text = repository.descpription
        star.tintColor = repository.starColor.color
        starCount.text = repository.starCount
        starCount.textColor = repository.starColor.color
    }
}
