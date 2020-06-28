//
//  StarCoor+Extension.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/08/25.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import UIKit

extension StarCount {
    var color: UIColor {
        switch self {
        case .many:
            return .red
        case .few:
            return .lightGray
        }
    }
}
