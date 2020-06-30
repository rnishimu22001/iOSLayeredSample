//
//  MockDetailUseCase.swift
//  iOSLayeredSampleTests
//
//  Created by rnishimu on 2020/06/30.
//  Copyright © 2020 rnishimu22001. All rights reserved.
//

import Foundation
import Combine
@testable import iOSLayeredSample

final class MockDetailUseCase: DetailUseCaseProtocol {

    var invokedReload = false
    var invokedReloadCount = 0
    var invokedReloadParameters: (fullName: String, Void)?
    var invokedReloadParametersList = [(fullName: String, Void)]()
    var stubbedReloadResult: (profile: PassthroughSubject<CommunityProfile, Error>, otherModules: Publishers.Zip3<Publishers.Catch<Publishers.Map<PassthroughSubject<Release, Error>, Release?>, Just<Release?>>, Publishers.Catch<PassthroughSubject<[Collaborator], Error>, Just<[Collaborator]>>, Publishers.Catch<PassthroughSubject<[Branch], Error>, Just<[Branch]>>>)!

    func reload(repository fullName: String) ->
        (profile: PassthroughSubject<CommunityProfile, Error>,
            otherModules: Publishers.Zip3<Publishers.Catch<Publishers.Map<PassthroughSubject<Release, Error>, Release?>, Just<Release?>>, Publishers.Catch<PassthroughSubject<[Collaborator], Error>, Just<[Collaborator]>>, Publishers.Catch<PassthroughSubject<[Branch], Error>, Just<[Branch]>>>) {
        invokedReload = true
        invokedReloadCount += 1
        invokedReloadParameters = (fullName, ())
        invokedReloadParametersList.append((fullName, ()))
        return stubbedReloadResult
    }
}
