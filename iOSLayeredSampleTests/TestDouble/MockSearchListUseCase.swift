//
//  MockSearchListUseCase.swift
//  iOSLayeredSampleTests
//
//  Created by rnishimu on 2020/06/28.
//  Copyright © 2020 rnishimu22001. All rights reserved.
//

import Foundation
import Combine
@testable import iOSLayeredSample

final class MockSearchListUseCase: SearchListUseCaseProtocol {

    var invokedUpdate = false
    var invokedUpdateCount = 0
    var invokedUpdateParameters: (searchQuery: String, Void)?
    var invokedUpdateParametersList = [(searchQuery: String, Void)]()
    var stubbedUpdateResult: PassthroughSubject<(result: [Repository], nextURL: URL?), Error> = .init()

    func update(searchQuery: String) -> PassthroughSubject<(result: [Repository], nextURL: URL?), Error> {
        invokedUpdate = true
        invokedUpdateCount += 1
        invokedUpdateParameters = (searchQuery, ())
        invokedUpdateParametersList.append((searchQuery, ()))
        return stubbedUpdateResult
    }

    var invokedLoad = false
    var invokedLoadCount = 0
    var invokedLoadParameters: (url: URL, Void)?
    var invokedLoadParametersList = [(url: URL, Void)]()
    var stubbedLoadResult: PassthroughSubject<(result: [Repository], nextURL: URL?), Error>!

    func load(next url: URL) -> PassthroughSubject<(result: [Repository], nextURL: URL?), Error> {
        invokedLoad = true
        invokedLoadCount += 1
        invokedLoadParameters = (url, ())
        invokedLoadParametersList.append((url, ()))
        return stubbedLoadResult
    }
}
