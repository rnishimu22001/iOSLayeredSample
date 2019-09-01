//
//  LoadingDisplayable.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/08/03.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import UIKit

struct LoadingDisplayData: TableViewDisplayable {
    static var tableViewCellClass: UITableViewCell.Type {
        return LoadingCell.self
    }
}
