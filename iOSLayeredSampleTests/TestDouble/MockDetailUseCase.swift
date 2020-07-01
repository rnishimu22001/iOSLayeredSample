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
    var stubbedReloadResult: (profile: PassthroughSubject<CommunityProfile, Error>, otherModules: Publishers.Zip3<AnyPublisher<Release?, Just<Release?>.Failure>, AnyPublisher<[Collaborator], Just<[Collaborator]>.Failure>, AnyPublisher<[Branch], Just<[Branch]>.Failure>>)!

    func reload(repository fullName: String) ->
        (profile: PassthroughSubject<CommunityProfile, Error>,
            otherModules: Publishers.Zip3<AnyPublisher<Release?, Just<Release?>.Failure>, AnyPublisher<[Collaborator], Just<[Collaborator]>.Failure>, AnyPublisher<[Branch], Just<[Branch]>.Failure>>) {
        invokedReload = true
        invokedReloadCount += 1
        invokedReloadParameters = (fullName, ())
        invokedReloadParametersList.append((fullName, ()))
        return stubbedReloadResult
    }
}
