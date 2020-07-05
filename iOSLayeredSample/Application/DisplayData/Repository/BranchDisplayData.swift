//
//  BranchDisplayData.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/10/05.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import Foundation

struct BranchDisplayData: Identifiable {
    let id = UUID()
    let name: String
    let shouldHideProtected: Bool
}

extension BranchDisplayData {
    init(with branch: Branch) {
        self.name = branch.name
        self.shouldHideProtected = !branch.isProtected
    }
}
