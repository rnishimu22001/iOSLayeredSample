//
//  DetailUseCase.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/08/18.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import Foundation
import Combine

protocol DetailUseCaseProtocol {
    /// ページの再読み込みに必要なデータを集めて、利用可能なものを通知する
    func reload(repository fullName: String) ->
        (profile: PassthroughSubject<CommunityProfile, Error>,
        otherModules: Publishers.Zip3<AnyPublisher<Release?, Just<Release?>.Failure>, AnyPublisher<[Collaborator], Just<[Collaborator]>.Failure>, AnyPublisher<[Branch], Just<[Branch]>.Failure>>)
}

final class DetailUseCase: DetailUseCaseProtocol {
   
    private let profileRepository: CommunityProfileRepositoryProtocol
    private let releaseRepository: ReleaseRepositoryProtocol
    private let collaboratorRepository: CollaboratorRepositoryProtocol
    private let branchRepository: BranchesRepositoryProtocol
    
    /// Collaboratorの表示数
    private let displayCollaboratorsCount = 5

    init(profileRepository: CommunityProfileRepositoryProtocol = CommunityProfileRepository(),
         releaseRepository: ReleaseRepositoryProtocol = ReleaseRepository(),
         collaboratorRepository: CollaboratorRepositoryProtocol = CollaboratorRepository(),
         branchRepository: BranchesRepositoryProtocol = BranchesRepository()) {
        self.profileRepository = profileRepository
        self.releaseRepository = releaseRepository
        self.collaboratorRepository = collaboratorRepository
        self.branchRepository = branchRepository
    }
    
    func reload(repository fullName: String) ->
        (profile: PassthroughSubject<CommunityProfile, Error>,
        otherModules: Publishers.Zip3<AnyPublisher<Release?, Just<Release?>.Failure>, AnyPublisher<[Collaborator], Just<[Collaborator]>.Failure>, AnyPublisher<[Branch], Just<[Branch]>.Failure>>) {
       
        let profileSubject = profileRepository.reload(repository: fullName)
        let releaseSubject = reloadLatestRelease(repository: fullName)
        let collaboratorSubject = reloadCollaborator(repository: fullName)
        let branchesSubject = reloadBranches(repository: fullName)
        
        let otherModulesSubject = releaseSubject
            .zip(collaboratorSubject, branchesSubject)
            
        return (profile: profileSubject, otherModules: otherModulesSubject)
    }
    
    private func reloadLatestRelease(repository fullName: String) -> AnyPublisher<Release?, Just<Release?>.Failure> {
        releaseRepository
            .reloadLatestRelease(repository: fullName)
            .map({ (release) -> Release? in
                return release
            })
            .catch({ (_) -> Just<Release?> in
                return Just(nil)
            })
            .eraseToAnyPublisher()
    }
    
    private func reloadCollaborator(repository fullName: String) -> AnyPublisher<[Collaborator], Just<[Collaborator]>.Failure> {
        let displayCollaboratorsCount = self.displayCollaboratorsCount
        return collaboratorRepository
            .reload(repositoy: fullName)
            .map({ collaborators in
                return Array(collaborators.prefix(displayCollaboratorsCount))
            })
            .catch({ (_) -> Just<[Collaborator]> in
                return Just([])
            })
            .eraseToAnyPublisher()
    }
    
    private func reloadBranches(repository fullName: String) -> AnyPublisher<[Branch], Just<[Branch]>.Failure> {
        branchRepository
            .reloadBranches(inRepositoy: fullName)
            .catch({ (_) -> Just<[Branch]> in
                return Just([])
            })
            .eraseToAnyPublisher()
    }
}
