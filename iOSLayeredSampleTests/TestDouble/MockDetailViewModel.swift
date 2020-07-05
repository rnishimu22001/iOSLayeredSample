//
//  MockDetailViewModel.swift
//  iOSLayeredSampleTests
//
//  Created by rnishimu on 2020/07/02.
//  Copyright © 2020 rnishimu22001. All rights reserved.
//

import Combine
@testable import iOSLayeredSample

final class MockDetailViewModel: DetailViewModelProtocol {
    var status: ContentsStatus = .initalized
    var contents: [Any] = []

    var invokedReload = false
    var invokedReloadCount = 0

    func reload() {
        invokedReload = true
        invokedReloadCount += 1
    }
}
