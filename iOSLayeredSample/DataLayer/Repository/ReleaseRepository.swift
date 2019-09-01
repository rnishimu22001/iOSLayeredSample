//
//  GithubRepositoryReleaseRepository.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/08/25.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import Foundation

protocol ReleaseRepositoryProtocol {
    var latestRelease: Release? { get }
    var isLoading: Bool { get }
    var error: Error? { get }
    func reload(repository fullName: String, completion: @escaping ((Result<Void, Error>) -> Void))
}

final class ReleaseRepository: ReleaseRepositoryProtocol {
    private(set) var isLoading: Bool = false
    private(set) var error: Error? = nil
    let client: ReleaseClientProtocol = ReleaseClient()
    
    private(set) var latestRelease: Release?
    
    func reload(repository fullName: String, completion: @escaping ((Result<Void, Error>) -> Void)) {
        self.isLoading = true
        self.error = nil
        client.requestLatestRelease(repository: fullName) { [weak self] result, _ in
            self?.isLoading = false
            switch result {
            case .failure(let error):
                self?.error = error
                completion(.failure(error))
            case .success(let release):
                self?.latestRelease = release
                completion(.success(()))
            }
        }
    }
}

