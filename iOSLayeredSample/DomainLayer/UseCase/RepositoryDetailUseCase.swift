//
//  RepositoryDetailUseCase.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/08/18.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import Foundation

protocol RepositoryDetailUseCaseProtocol {
    var profile: CommunityProfile? { get }
    var latestRelease: Release? { get }
    var collaborators: [Collaborator] { get }
    var profileRepository: GithubRepositoryCommunityProfileRepositoryProtocol { get }
    /// エラーの場合はtrue
    /// CommunityProfileがエラーならエラー表示にする
    var isError: Bool { get }
    /// ロード中の場合はtrue
    /// CommunityProfileがロード中ならロードにする
    var isLoading: Bool { get }
    /// ロードフッター表示が必要な場合はtrue
    /// CommunityProfile以下がリクエスト中ならロードフッター表示
    var shouldShowLoadingFooter: Bool { get }
    /// データ更新の通知先
    var delegate: RepositoryDetailUseCaseDelegate? { get set }
    /// ページの再読み込み時に呼ばれる
    func reload(repository fullName: String)
}

protocol RepositoryDetailUseCaseDelegate: class {
    /// profileのロード完了時に呼ばれる
    func repositoryDetailUseCase(_ useCase: RepositoryDetailUseCaseProtocol, didLoad profile: CommunityProfile?)
    /// リリース情報とCollaborator情報のロード完了時に呼ばれる
    func repositoryDetailUseCase(_ useCase: RepositoryDetailUseCaseProtocol, didLoad latestRelease: Release?, collaborators: [Collaborator])
}

final class RepositoryDetailUseCase: RepositoryDetailUseCaseProtocol {
    
    var collaborators: [Collaborator] {
        return collaboratorRepository.collaborators
    }
    
    var profile: CommunityProfile? {
        return profileRepository.profile
    }
    
    var latestRelease: Release? {
        return releaseRepository.latestRelease
    }
    
    var isLoading: Bool {
        return self.profileRepository.isLoading
    }
    
    var isError: Bool {
        return self.profileRepository.error != nil
    }
    
    var shouldShowLoadingFooter: Bool {
        return self.releaseRepository.isLoading || self.collaboratorRepository.isLoading
    }

    let queue = DispatchQueue(label: "RepositoryDetailUseCase")
    
    weak var delegate: RepositoryDetailUseCaseDelegate?
    
    let profileRepository: GithubRepositoryCommunityProfileRepositoryProtocol = GithubRepositoryCommunityProfileRepository()
    let releaseRepository: GithubRepositoryReleaseRepositoryProtocol = GithubRepositoryReleaseRepository()
    let collaboratorRepository: GithubRepositoryCollaboratorRepository = GithubRepositoryCollaboratorRepository()
    
    func reload(repository fullName: String) {
        
        profileRepository.reload(repository: fullName) { [weak self] _ in
            guard let self = self else { return }
            self.delegate?.repositoryDetailUseCase(self, didLoad: self.profile)
        }
        
        let group = DispatchGroup()
        
        queue.async(group: group) { [weak self] in
            group.enter()
            self?.releaseRepository.reload(repository: fullName) { _ in
                group.leave()
            }
        }
        
        queue.async(group: group) { [weak self] in
            group.enter()
            self?.collaboratorRepository.reload(repositoy: fullName) { _ in
                group.leave()
            }
        }
        
        group.notify(queue: queue) { [weak self] in
            guard let self = self else { return }
            self.delegate?.repositoryDetailUseCase(self, didLoad: self.latestRelease, collaborators: self.collaborators)
        }
    }
}

