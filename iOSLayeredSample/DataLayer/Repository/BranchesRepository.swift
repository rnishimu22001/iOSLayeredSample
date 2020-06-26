//
//  BranchesRepository.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/10/05.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import Combine

protocol BranchesRepositoryProtocol {
    func reloadBranches(inRepositoy fullName: String) -> PassthroughSubject<[Branch], Error>
}

struct BranchesRepository: BranchesRepositoryProtocol {
    private let client: BranchesRequestClientProtocol
    
    init(client: BranchesRequestClientProtocol = BranchesRequestClient()) {
        self.client = client
    }
    
    func reloadBranches(inRepositoy fullName: String) -> PassthroughSubject<[Branch], Error> {
        
        let subject = PassthroughSubject<[Branch], Error>()

        self.client.requestBranch(inRepository: fullName) { result, _ in
            switch result {
            case .success(let branchList):
                let branches = branchList.map { $0.converted }
                subject.send(branches)
                subject.send(completion: .finished)
            case .failure(let error):
                subject.send(completion: .failure(error))
            }
        }
        return subject
    }
}
