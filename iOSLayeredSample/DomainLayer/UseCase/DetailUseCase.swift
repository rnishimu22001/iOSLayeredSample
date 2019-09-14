//
//  DetailUseCase.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/08/18.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import Foundation

protocol DetailUseCaseProtocol {
    /// データ更新の通知先
    var delegate: DetailUseCaseDelegate? { get set }
    /// ページの再読み込み時に呼ばれる
    func reload(repository fullName: String)
}

protocol DetailUseCaseDelegate: class {
    /// profileのロード完了時に呼ばれる
    func detailUseCase(_ useCase: DetailUseCaseProtocol, didLoad profile: CommunityProfileData?)
    /// リリース情報とCollaborator情報のロード完了時に呼ばれる
    func detailUseCase(_ useCase: DetailUseCaseProtocol, didLoad latestRelease: ReleaseData?, collaborators: [CollaboratorData])
}

final class DetailUseCase: DetailUseCaseProtocol {

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
        
        profileRepository.reload(repository: fullName) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let profile):
                self.delegate?.detailUseCase(self, didLoad: profile)
            case .failure:
                self.delegate?.detailUseCase(self, didLoad: nil)
            }
        }
        
        let group = DispatchGroup()
        var latestRelease: ReleaseData?
        var collaborators: [CollaboratorData] = []
        queue.async(group: group) { [weak self] in
            group.enter()
            self?.releaseRepository.reload(repository: fullName) { result in
                switch result {
                 case .success(let data):
                     latestRelease = data
                 case .failure:
                     break
                 }
                group.leave()
            }
        }
        
        queue.async(group: group) { [weak self] in
            group.enter()
            self?.collaboratorRepository.reload(repositoy: fullName) { result in
                switch result {
                case .success(let data):
                    collaborators = data
                case .failure:
                    break
                }
                group.leave()
            }
        }
        
        group.notify(queue: queue) { [weak self] in
            guard let self = self else { return }
            self.delegate?.detailUseCase(self, didLoad: latestRelease, collaborators: collaborators)
        }
    }
}

