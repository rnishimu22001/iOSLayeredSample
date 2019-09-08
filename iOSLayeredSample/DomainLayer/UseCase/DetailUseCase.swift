//
//  DetailUseCase.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/08/18.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import Foundation

protocol DetailUseCaseProtocol {
    var profile: CommunityProfile? { get }
    var latestRelease: Release? { get }
    var collaborators: [Collaborator] { get }
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
    var delegate: DetailUseCaseDelegate? { get set }
    /// ページの再読み込み時に呼ばれる
    func reload(repository fullName: String)
}

protocol DetailUseCaseDelegate: class {
    /// profileのロード完了時に呼ばれる
    func detailUseCase(_ useCase: DetailUseCaseProtocol, didLoad profile: CommunityProfile?)
    /// リリース情報とCollaborator情報のロード完了時に呼ばれる
    func detailUseCase(_ useCase: DetailUseCaseProtocol, didLoad latestRelease: Release?, collaborators: [Collaborator])
}

final class DetailUseCase: DetailUseCaseProtocol {
    
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
    
    weak var delegate: DetailUseCaseDelegate?
    
    let profileRepository: CommunityProfileRepositoryProtocol
    let releaseRepository: ReleaseRepositoryProtocol
    let collaboratorRepository: CollaboratorRepository
    
    init(profileRepository: CommunityProfileRepositoryProtocol = CommunityProfileRepository(),
         releaseRepository: ReleaseRepositoryProtocol = ReleaseRepository(),
         collaboratorRepository: CollaboratorRepository = CollaboratorRepository()) {
        self.profileRepository = profileRepository
        self.releaseRepository = releaseRepository
        self.collaboratorRepository = collaboratorRepository
    }
    
    func reload(repository fullName: String) {
        
        profileRepository.reload(repository: fullName) { [weak self] _ in
            guard let self = self else { return }
            self.delegate?.detailUseCase(self, didLoad: self.profile)
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
            self.delegate?.detailUseCase(self, didLoad: self.latestRelease, collaborators: self.collaborators)
        }
    }
}

