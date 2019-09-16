//
//  DetailViewModel.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/08/18.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import Combine

protocol DetailViewModelProtocol {
    var status: CurrentValueSubject<ContentsStatus, Never> { get }
    var contents: CurrentValueSubject<[Any], Never> { get }
    var repositoryFullName: String { get }
    func reload()
}

final class DetailViewModel: DetailViewModelProtocol {
    let status: CurrentValueSubject<ContentsStatus, Never> = .init(.initalized)
    let contents: CurrentValueSubject<[Any], Never> = .init([])
    private(set) var useCase: DetailUseCaseProtocol
    
    private(set) var otherModulesCancellable: AnyCancellable?
    private(set) var profileCancellable: AnyCancellable?
     
    let repositoryFullName: String
    
    init(repositoryFullName: String,
         useCase: DetailUseCaseProtocol = DetailUseCase()) {
        self.repositoryFullName = repositoryFullName
        self.useCase = useCase
    }
    
    func reload() {
        status.value = .loading
        let publishers = useCase.reload(repository: repositoryFullName)
        otherModulesCancellable = publishers.otherModules.sink(receiveCompletion: { [weak self] _ in
            self?.otherModulesCancellable?.cancel()
            self?.otherModulesCancellable = nil
        }, receiveValue: { [weak self] others in
            self?.didLoad(latestRelease: others.0, collaborators: others.1)
        })
        
        profileCancellable = publishers.profile.sink(receiveCompletion: { [weak self] _ in
            self?.profileCancellable?.cancel()
            self?.profileCancellable = nil
        }, receiveValue: { [weak self] profile in
            self?.didLoad(profile: profile)
        })
    }
}

extension DetailViewModel {
    func didLoad(latestRelease: Release?, collaborators: [Collaborator]) {
        var filterd = contents.value.filter { !($0 is LoadingDisplayData) }
        if let release = latestRelease {
            filterd.append(ReleaseDisplayData(with: release, status: ReleaseStatus(isDraft: release.isDraft, isPrerelease: release.isPreRelease)))
        }
        if !collaborators.isEmpty {
            filterd.append(CollaboratorsDisplayData(with: collaborators))
        }
        contents.value = filterd
    }
    
    func didLoad(profile: CommunityProfile?) {
        guard let communityProfile = profile else {
            status.value = .error
            return
        }
        let display = CommunityProfileDisplayData(with: communityProfile)
        contents.value.insert(display, at: contents.value.startIndex)
        if self.otherModulesCancellable != nil {
            contents.value.append(LoadingDisplayData(nextLink: nil))
        }
        status.value = .browsable
    }
}
