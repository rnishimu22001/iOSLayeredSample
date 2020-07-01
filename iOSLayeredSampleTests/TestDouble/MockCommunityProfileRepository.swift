//
//  MockCommunityProfileRepository.swift
//  iOSLayeredSampleTests
//
//  Created by rnishimu on 2020/07/01.
//  Copyright © 2020 rnishimu22001. All rights reserved.
//

import Combine
@testable import iOSLayeredSample

final class MockCommunityProfileRepository: CommunityProfileRepositoryProtocol {

    var invokedReload = false
    var invokedReloadCount = 0
    var invokedReloadParameters: (fullName: String, Void)?
    var invokedReloadParametersList = [(fullName: String, Void)]()
    var stubbedReloadResult: PassthroughSubject<CommunityProfile, Error>!

    func reload(repository fullName: String) -> PassthroughSubject<CommunityProfile, Error> {
        invokedReload = true
        invokedReloadCount += 1
        invokedReloadParameters = (fullName, ())
        invokedReloadParametersList.append((fullName, ()))
        return stubbedReloadResult
    }
}
