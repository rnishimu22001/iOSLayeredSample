//
//  ReleaseRepository.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/08/25.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import Foundation
import Combine

protocol ReleaseRepositoryProtocol {
    func reload(repository fullName: String) -> PassthroughSubject<Release, Error>
}

struct ReleaseRepository: ReleaseRepositoryProtocol {
    
    private let client: ReleaseClientProtocol
        
    init(client: ReleaseClientProtocol = ReleaseClient()) {
        self.client = client
    }
    
    func reload(repository fullName: String) -> PassthroughSubject<Release, Error> {
        let subject = PassthroughSubject<Release, Error>()
        client.requestLatestRelease(repository: fullName) { result, _ in
            switch result {
            case .success(let data):
                subject.send(data.converted)
                subject.send(completion: .finished)
            case .failure(let error):
                subject.send(completion: .failure(error))
            }
            
        }
        return subject
    }
}
