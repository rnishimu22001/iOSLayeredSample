//
//  MockSearchListViewModel.swift
//  iOSLayeredSampleTests
//
//  Created by rnishimu on 2020/07/01.
//  Copyright © 2020 rnishimu22001. All rights reserved.
//

import Combine
@testable import iOSLayeredSample

final class MockSearchListViewModel: SearchListViewModelProtocol {

    var invokedStatusGetter = false
    var invokedStatusGetterCount = 0
    var stubbedStatus: CurrentValueSubject<ContentsStatus, Never>!

    var status: CurrentValueSubject<ContentsStatus, Never> {
        invokedStatusGetter = true
        invokedStatusGetterCount += 1
        return stubbedStatus
    }

    var invokedContentsGetter = false
    var invokedContentsGetterCount = 0
    var stubbedContents: CurrentValueSubject<[TableViewDisplayable], Never>!

    var contents: CurrentValueSubject<[TableViewDisplayable], Never> {
        invokedContentsGetter = true
        invokedContentsGetterCount += 1
        return stubbedContents
    }

    var invokedUpdate = false
    var invokedUpdateCount = 0
    var invokedUpdateParameters: (searchQuery: String?, Void)?
    var invokedUpdateParametersList = [(searchQuery: String?, Void)]()

    func update(searchQuery: String?) {
        invokedUpdate = true
        invokedUpdateCount += 1
        invokedUpdateParameters = (searchQuery, ())
        invokedUpdateParametersList.append((searchQuery, ()))
    }

    var invokedLoadNextContents = false
    var invokedLoadNextContentsCount = 0

    func loadNextContents() {
        invokedLoadNextContents = true
        invokedLoadNextContentsCount += 1
    }

    var invokedRepositoryInList = false
    var invokedRepositoryInListCount = 0
    var invokedRepositoryInListParameters: (index: Int, Void)?
    var invokedRepositoryInListParametersList = [(index: Int, Void)]()
    var stubbedRepositoryInListResult: RepositoryDisplayData!

    func repositoryInList(at index: Int) -> RepositoryDisplayData? {
        invokedRepositoryInList = true
        invokedRepositoryInListCount += 1
        invokedRepositoryInListParameters = (index, ())
        invokedRepositoryInListParametersList.append((index, ()))
        return stubbedRepositoryInListResult
    }
}
