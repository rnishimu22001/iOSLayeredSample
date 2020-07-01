//
//  MockReleaseReposiotry.swift
//  iOSLayeredSampleTests
//
//  Created by rnishimu on 2020/07/01.
//  Copyright © 2020 rnishimu22001. All rights reserved.
//

import Combine
@testable import iOSLayeredSample

final class MockReleaseReposiotry: ReleaseRepositoryProtocol {

    var invokedReloadLatestRelease = false
    var invokedReloadLatestReleaseCount = 0
    var invokedReloadLatestReleaseParameters: (fullName: String, Void)?
    var invokedReloadLatestReleaseParametersList = [(fullName: String, Void)]()
    var stubbedReloadLatestReleaseResult: PassthroughSubject<Release, Error> = .init()

    func reloadLatestRelease(repository fullName: String) -> PassthroughSubject<Release, Error> {
        invokedReloadLatestRelease = true
        invokedReloadLatestReleaseCount += 1
        invokedReloadLatestReleaseParameters = (fullName, ())
        invokedReloadLatestReleaseParametersList.append((fullName, ()))
        return stubbedReloadLatestReleaseResult
    }
}
