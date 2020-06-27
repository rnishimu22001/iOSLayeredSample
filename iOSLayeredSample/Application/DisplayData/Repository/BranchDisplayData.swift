//
//  BranchDisplayData.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/10/05.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

struct BranchDisplayData {
    let name: String
    let shouldHideProtected: Bool
}

extension BranchDisplayData {
    init(with branch: Branch) {
        self.name = branch.name
        self.shouldHideProtected = !branch.isProtected
    }
}
