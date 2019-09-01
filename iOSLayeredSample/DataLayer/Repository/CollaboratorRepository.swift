//
//  GithubRepositoryCollaboratorRepository.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/08/25.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

protocol CollaboratorRepositoryProtocol {
    var collaborators: [Collaborator] { get }
    var isLoading: Bool { get }
    var error: Error? { get }
    func reload(repositoy fullName: String, completion: @escaping ((Result<Void, Error>) -> Void))
}

final class CollaboratorRepository: CollaboratorRepositoryProtocol {
    let client: CollaboratorsClientProtocol = CollaboratorsClient()
    private(set) var isLoading: Bool = false
    private(set) var error: Error? = nil
    
    private(set) var collaborators: [Collaborator] = []
    
    func reload(repositoy fullName: String, completion: @escaping ((Result<Void, Error>) -> Void)) {
        self.isLoading = true
        self.error = nil
        client.requestCollaborators(repository: fullName) { [weak self] result, _ in
            self?.isLoading = false
            switch result {
            case .success(let collaborators):
                self?.collaborators = collaborators
                completion(.success(()))
            case .failure(let error):
                self?.error = error
                completion(.failure(error))
            }
        }
    }
}
