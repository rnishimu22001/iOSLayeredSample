//
//  CollaboratorRepository.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/08/25.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import Combine

protocol CollaboratorRepositoryProtocol {
    func reload(repositoy fullName: String) -> PassthroughSubject<[Collaborator], Error>
}

struct CollaboratorRepository: CollaboratorRepositoryProtocol {
    
    private let client: CollaboratorsClientProtocol
    
    init(client: CollaboratorsClientProtocol = CollaboratorsClient()) {
        self.client = client
    }
    func reload(repositoy fullName: String) -> PassthroughSubject<[Collaborator], Error> {
        let subject = PassthroughSubject<[Collaborator], Error>()
        client.requestCollaborators(repository: fullName) { result, response in
            switch result {
            case .success(let data):
                subject.send(data.map { $0.converted })
                subject.send(completion: .finished)
            case .failure(let error):
                subject.send(completion: .failure(error))
            }
        }
        return subject
    }
}
