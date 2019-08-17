//
//  LoadingCell.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/08/03.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import UIKit

final class LoadingCell: UITableViewCell {
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    override func prepareForReuse() {
        self.indicator.startAnimating()
    }
}
