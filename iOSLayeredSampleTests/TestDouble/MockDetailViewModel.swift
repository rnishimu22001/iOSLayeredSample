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

    var invokedStatusGetter = false
    var invokedStatusGetterCount = 0
    var stubbedStatus: CurrentValueSubject<ContentsStatus, Never> = .init(.initalized)

    var status: CurrentValueSubject<ContentsStatus, Never> {
        invokedStatusGetter = true
        invokedStatusGetterCount += 1
        return stubbedStatus
    }

    var invokedContentsGetter = false
    var invokedContentsGetterCount = 0
    var stubbedContents: CurrentValueSubject<[Any], Never> = .init([])

    var contents: CurrentValueSubject<[Any], Never> {
        invokedContentsGetter = true
        invokedContentsGetterCount += 1
        return stubbedContents
    }

    var invokedReload = false
    var invokedReloadCount = 0

    func reload() {
        invokedReload = true
        invokedReloadCount += 1
    }
}
