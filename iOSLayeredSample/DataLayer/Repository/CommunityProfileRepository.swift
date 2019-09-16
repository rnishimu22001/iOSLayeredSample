//
//  CommunityProfileRepository.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/08/25.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import Combine

protocol CommunityProfileRepositoryProtocol {
    /// リポジトリの名前からコミュニティの情報を取得する
    func reload(repository fullName: String) -> PassthroughSubject<CommunityProfile, Error>
}

struct CommunityProfileRepository: CommunityProfileRepositoryProtocol {
    
    private let client: CommunityProfileClientProtocol
    
    init(client: CommunityProfileClientProtocol = CommunityProfileClient()) {
        self.client = client
    }
    
    func reload(repository fullName: String) -> PassthroughSubject<CommunityProfile, Error> {
        let subject = PassthroughSubject<CommunityProfile, Error>()
        client.requestProfile(repository: fullName) { result, _ in
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
