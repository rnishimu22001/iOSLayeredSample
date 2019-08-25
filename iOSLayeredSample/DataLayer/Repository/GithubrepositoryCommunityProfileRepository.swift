//
//  GithubrepositoryCommunityProfileRepository.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/08/25.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

protocol GithubRepositoryCommunityProfileRepositoryProtocol {
    var profile: CommunityProfile? { get }
    var client: RepositoryCommunityProfileClientProtocol { get }
    var isLoading: Bool { get }
    var error: Error? { get }
    func reload(repository fullName: String, completion: @escaping ((Result<Void, Error>) -> Void))
}

final class GithubRepositoryCommunityProfileRepository: GithubRepositoryCommunityProfileRepositoryProtocol {
    private(set) var isLoading: Bool = false
    private(set) var error: Error? = nil
    private(set) var profile: CommunityProfile?
    let client: RepositoryCommunityProfileClientProtocol = RepositoryCommunityProfileClient()
    
    func reload(repository fullName: String, completion: @escaping ((Result<Void, Error>) -> Void)) {
        self.isLoading = true
        self.error = nil
        client.requestProfile(repository: fullName) { [weak self] result, response in
            self?.isLoading = false
            switch result {
            case .success(let profile):
                self?.profile = profile
                completion(.success(()))
            case .failure(let error):
                self?.error = error
                completion(.failure(error))
            }
        }
    }
}
