//
//  CollaboratorRepository.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/08/25.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

protocol CollaboratorRepositoryProtocol {
    func reload(repositoy fullName: String, completion: @escaping ((Result<[Collaborator], Error>) -> Void))
}

struct CollaboratorRepository: CollaboratorRepositoryProtocol {
    let client: CollaboratorsClientProtocol
    
    init(client: CollaboratorsClientProtocol = CollaboratorsClient()) {
        self.client = client
    }
    
    func reload(repositoy fullName: String, completion: @escaping ((Result<[Collaborator], Error>) -> Void)) {
        client.requestCollaborators(repository: fullName) { result, response in
            switch result {
            case .success(let data):
                completion(.success(data.map { $0.converted }))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
