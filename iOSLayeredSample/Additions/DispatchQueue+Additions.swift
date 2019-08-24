//
//  DispatchQueue+Additions.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/08/24.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import Foundation

extension DispatchQueue {
    static func asyncAtMain(_ execute: @escaping (() -> Void)) {
        guard !Thread.isMainThread else {
            execute()
            return
        }
        DispatchQueue.main.async { execute() }
    }
}
