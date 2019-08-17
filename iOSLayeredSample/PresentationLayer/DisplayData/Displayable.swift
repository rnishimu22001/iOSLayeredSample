//
//  Displayable.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/08/03.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import UIKit

protocol Displayable {
    static var tableViewCellClass: UITableViewCell.Type { get }
}
