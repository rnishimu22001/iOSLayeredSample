//
//  MockBranchRepository.swift
//  iOSLayeredSampleTests
//
//  Created by rnishimu on 2020/07/01.
//  Copyright © 2020 rnishimu22001. All rights reserved.
//

import Combine
@testable import iOSLayeredSample

final class MockBranchesRepository: BranchesRepositoryProtocol {

    var invokedReloadBranches = false
    var invokedReloadBranchesCount = 0
    var invokedReloadBranchesParameters: (fullName: String, Void)?
    var invokedReloadBranchesParametersList = [(fullName: String, Void)]()
    var stubbedReloadBranchesResult: PassthroughSubject<[Branch], Error>!

    func reloadBranches(inRepositoy fullName: String) -> PassthroughSubject<[Branch], Error> {
        invokedReloadBranches = true
        invokedReloadBranchesCount += 1
        invokedReloadBranchesParameters = (fullName, ())
        invokedReloadBranchesParametersList.append((fullName, ()))
        return stubbedReloadBranchesResult
    }
}
