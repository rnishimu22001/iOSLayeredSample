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
        otherModules: Publishers.Zip<Publishers.Catch<Publishers.Map<PassthroughSubject<Release, Error>, Release?>, Just<Release?>>, Publishers.Catch<PassthroughSubject<[Collaborator], Error>, Just<[Collaborator]>>>)
}

final class DetailUseCase: DetailUseCaseProtocol {
   
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
    
    func reload(repository fullName: String) ->
        (profile: PassthroughSubject<CommunityProfile, Error>,
        otherModules: Publishers.Zip<Publishers.Catch<Publishers.Map<PassthroughSubject<Release, Error>, Release?>, Just<Release?>>, Publishers.Catch<PassthroughSubject<[Collaborator], Error>, Just<[Collaborator]>>>) {
       
        let profileSubject = profileRepository.reload(repository: fullName)
            let releaseSubject = releaseRepository.reloadLatestRelease(repository: fullName).map({ (release) -> Release? in
                return release
            }).catch({ (_) -> Just<Release?> in
                return Just(nil)
            })
            
            let collaboratorSubject = collaboratorRepository.reload(repositoy: fullName).catch({ (_) -> Just<[Collaborator]> in
                return Just([])
            })
        let otherModulesSubject =  releaseSubject.zip(collaboratorSubject)
            
        return (profile: profileSubject, otherModules: otherModulesSubject)
    }
}

