//
//  Navigator.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2020/07/01.
//  Copyright © 2020 rnishimu22001. All rights reserved.
//

import UIKit

protocol Navigator {
    func push(viewControler: UIViewController)
}

struct UINavigatorImplementation: Navigator {
    let navigation: UINavigationController?
    func push(viewControler: UIViewController) {
        navigation?.pushViewController(viewControler, animated: true)
    }
}
