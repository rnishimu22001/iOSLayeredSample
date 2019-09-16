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
        otherModules: Publishers.Zip<PassthroughSubject<Release, Error>, PassthroughSubject<[Collaborator], Error>>)
}

final class DetailUseCase: DetailUseCaseProtocol {

    let queue = DispatchQueue(label: "RepositoryDetailUseCase")
   
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
        otherModules: Publishers.Zip<PassthroughSubject<Release, Error>, PassthroughSubject<[Collaborator], Error>>) {
       
        let profileSubject = profileRepository.reload(repository: fullName)
        let releaseSubject = releaseRepository.reloadLatestRelease(repository: fullName)
        let collaboratorSubject = collaboratorRepository.reload(repositoy: fullName)
        let otherModulesSubject =  releaseSubject.zip(collaboratorSubject)
            
        return (profile: profileSubject, otherModules: otherModulesSubject)
    }
}

