//
//  MockCollaboratorRepository.swift
//  iOSLayeredSampleTests
//
//  Created by rnishimu on 2020/07/01.
//  Copyright © 2020 rnishimu22001. All rights reserved.
//

import Combine
@testable import iOSLayeredSample

final class MockCollaboratorRepository: CollaboratorRepositoryProtocol {

    var invokedReload = false
    var invokedReloadCount = 0
    var invokedReloadParameters: (fullName: String, Void)?
    var invokedReloadParametersList = [(fullName: String, Void)]()
    var stubbedReloadResult: PassthroughSubject<[Collaborator], Error>!

    func reload(repositoy fullName: String) -> PassthroughSubject<[Collaborator], Error> {
        invokedReload = true
        invokedReloadCount += 1
        invokedReloadParameters = (fullName, ())
        invokedReloadParametersList.append((fullName, ()))
        return stubbedReloadResult
    }
}
