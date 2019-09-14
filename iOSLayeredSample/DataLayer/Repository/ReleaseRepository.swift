//
//  ReleaseRepository.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/08/25.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import Foundation

protocol ReleaseRepositoryProtocol {
    func reload(repository fullName: String, completion: @escaping ((Result<ReleaseData, Error>) -> Void))
}

struct ReleaseRepository: ReleaseRepositoryProtocol {
    private let client: ReleaseClientProtocol
        
    init(client: ReleaseClientProtocol = ReleaseClient()) {
        self.client = client
    }
    
    private(set) var latestRelease: ReleaseData?
    
    func reload(repository fullName: String, completion: @escaping ((Result<ReleaseData, Error>) -> Void)) {
        client.requestLatestRelease(repository: fullName) { result, _ in
            completion(result)
        }
    }
}
