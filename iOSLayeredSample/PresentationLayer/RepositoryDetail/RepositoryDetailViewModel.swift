//
//  RepositoryDetailViewModel.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/08/18.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import Combine

protocol RepositoryDetailViewModelProtocol {
    var status: CurrentValueSubject<ContentsStatus, Never> { get set }
    
}

final class RepositoryDetailViewModel: RepositoryDetailViewModelProtocol {
    var status: CurrentValueSubject<ContentsStatus, Never> = .init(.initalized)
    let useCase: RepositoryDetailUseCaseProtocol
    
    private var collaborators: CollaboratorsDisplayable?
    private var latestRelease: ReleaseDisplayable?
    private var profile: CommunityProfileDisplayable?
    
    init(useCase: RepositoryDetailUseCaseProtocol = RepositoryDetailUseCase()) {
        self.useCase = useCase
    }
    
    func reload() {
        useCase.reload()
    }
    
    /// コンテンツのステータスの更新状態を見て通知が必要か、どのデータを更新させるかを決める
    func notifyDelegateIfNeeded() {
        
    }
    
    func updateStatus() {
        
    }
}

extension RepositoryDetailViewModel: RepositoryDetailUseCaseDelegate {
    func repositoryDetailUseCase(_ useCase: RepositoryDetailUseCaseProtocol, didLoad profile: CommunityProfile) {
        
    }
    
    func repositoryDetailUseCase(_ useCase: RepositoryDetailUseCaseProtocol, didLoad latestRelease: Release) {
        
    }
    
    func repositoryDetailUseCase(_ useCase: RepositoryDetailUseCaseProtocol, didLoad collaborators: [Collaborator]) {
        
    }
}
