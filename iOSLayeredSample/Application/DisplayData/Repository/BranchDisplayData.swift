//
//  BranchDisplayData.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/10/05.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

struct BranchDisplayData {
    let name: String
    let shouldHiddenProtected: Bool
}

extension BranchDisplayData {
    init(with branch: Branch) {
        self.name = branch.name
        self.shouldHiddenProtected = !branch.isProtected
    }
}
