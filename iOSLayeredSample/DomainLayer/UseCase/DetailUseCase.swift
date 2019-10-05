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
    /// ページの再読み込み時に呼ばれる
    func reload(repository fullName: String) ->
        (profile: PassthroughSubject<CommunityProfile, Error>,
        otherModules: Publishers.Zip3<Publishers.Catch<Publishers.Map<PassthroughSubject<Release, Error>, Release?>, Just<Release?>>, Publishers.Catch<PassthroughSubject<[Collaborator], Error>, Just<[Collaborator]>>, Publishers.Catch<PassthroughSubject<[Branch], Error>, Just<[Branch]>>>)
}

final class DetailUseCase: DetailUseCaseProtocol {

    let queue = DispatchQueue(label: "RepositoryDetailUseCase")
   
    let profileRepository: CommunityProfileRepositoryProtocol
    let releaseRepository: ReleaseRepositoryProtocol
    let collaboratorRepository: CollaboratorRepositoryProtocol
    let branchRepository: BranchesRepositoryProtocol

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
        otherModules: Publishers.Zip3<Publishers.Catch<Publishers.Map<PassthroughSubject<Release, Error>, Release?>, Just<Release?>>, Publishers.Catch<PassthroughSubject<[Collaborator], Error>, Just<[Collaborator]>>, Publishers.Catch<PassthroughSubject<[Branch], Error>, Just<[Branch]>>>) {
       
        let profileSubject = profileRepository.reload(repository: fullName)
            let releaseSubject = releaseRepository.reloadLatestRelease(repository: fullName).map({ (release) -> Release? in
                return release
            }).catch({ (_) -> Just<Release?> in
                return Just(nil)
            })
            
            let collaboratorSubject = collaboratorRepository.reload(repositoy: fullName).catch({ (_) -> Just<[Collaborator]> in
                return Just([])
            })
            
            let branchesSubject = branchRepository.reloadBranches(inRepositoy: fullName).catch({ (_) -> Just<[Branch]> in
                return Just([])
            })
            
            let otherModulesSubject =  releaseSubject.zip(collaboratorSubject, branchesSubject)
            
        return (profile: profileSubject, otherModules: otherModulesSubject)
    }
}

