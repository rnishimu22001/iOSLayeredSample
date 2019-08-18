//
//  RepositoryDetailUseCase.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/08/18.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

protocol RepositoryDetailUseCaseProtocol {
    var delegate: RepositoryDetailUseCaseDelegate? { get set }
    func reload()
}

protocol RepositoryDetailUseCaseDelegate: class {
    func repositoryDetailUseCase(_ useCase: RepositoryDetailUseCaseProtocol, didLoad profile: CommunityProfile)
    func repositoryDetailUseCase(_ useCase: RepositoryDetailUseCaseProtocol, didLoad latestRelease: Release)
    func repositoryDetailUseCase(_ useCase: RepositoryDetailUseCaseProtocol, didLoad collaborators: [Collaborator])
}

final class RepositoryDetailUseCase: RepositoryDetailUseCaseProtocol {
    weak var delegate: RepositoryDetailUseCaseDelegate?
    
    func reload() {
        
    }
}

