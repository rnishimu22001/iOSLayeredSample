//
//  RepositoryDetailUseCase.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/08/18.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

protocol RepositoryDetailUseCaseProtocol {
    /// データ更新の通知先
    var delegate: RepositoryDetailUseCaseDelegate? { get set }
    /// ページの再読み込み時に呼ばれる
    func reload()
}

protocol RepositoryDetailUseCaseDelegate: class {
    /// profileのロード完了時に呼ばれる
    func repositoryDetailUseCase(_ useCase: RepositoryDetailUseCaseProtocol, didLoad profile: CommunityProfile)
    /// リリース情報のロード完了時に呼ばれる
    func repositoryDetailUseCase(_ useCase: RepositoryDetailUseCaseProtocol, didLoad latestRelease: Release)
    /// Collaborator情報のロード完了時に呼ばれる
    func repositoryDetailUseCase(_ useCase: RepositoryDetailUseCaseProtocol, didLoad collaborators: [Collaborator])
}

final class RepositoryDetailUseCase: RepositoryDetailUseCaseProtocol {
    weak var delegate: RepositoryDetailUseCaseDelegate?
    
    func reload() {
        
    }
}

