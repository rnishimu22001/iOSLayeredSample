//
//  UINib+Additions.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/08/12.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import UIKit

extension UIView {
    static var nib: UINib {
        let name = self.className
        return UINib(nibName: name, bundle: nil)
    }
}
