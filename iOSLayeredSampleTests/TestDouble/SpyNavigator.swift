//
//  SpyNavigator.swift
//  iOSLayeredSampleTests
//
//  Created by rnishimu on 2020/07/01.
//  Copyright © 2020 rnishimu22001. All rights reserved.
//

import UIKit
@testable import iOSLayeredSample

final class SpyNavigator: Navigator {
    var invokedPush = false
    var invokedPushCount = 0
    var invokedPushParameters: (viewControler: UIViewController, Void)?
    var invokedPushParametersList = [(viewControler: UIViewController, Void)]()

    func push(viewControler: UIViewController) {
        invokedPush = true
        invokedPushCount += 1
        invokedPushParameters = (viewControler, ())
        invokedPushParametersList.append((viewControler, ()))
    }
}
