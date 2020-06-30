//
//  DetailViewModel.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/08/18.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import Combine

protocol DetailViewModelProtocol {
    /// 表示状態
    var status: CurrentValueSubject<ContentsStatus, Never> { get }
    /// 表示するコンテンツ
    var contents: CurrentValueSubject<[Any], Never> { get }
    /// 表示のリロード
    func reload()
}

final class DetailViewModel: DetailViewModelProtocol {
    let status: CurrentValueSubject<ContentsStatus, Never> = .init(.initalized)
    let contents: CurrentValueSubject<[Any], Never> = .init([])
    private(set) var useCase: DetailUseCaseProtocol
    
    private(set) var otherModulesCancellable: AnyCancellable?
    private(set) var profileCancellable: AnyCancellable?
    /// Collaboratorの表示数
    private let displayCollaboratorsCount = 5
    let repositoryFullName: String
    
    init(repositoryFullName: String,
         useCase: DetailUseCaseProtocol = DetailUseCase()) {
        self.repositoryFullName = repositoryFullName
        self.useCase = useCase
    }
    
    func reload() {
        status.value = .loading
        let publishers = useCase.reload(repository: repositoryFullName)
        otherModulesCancellable = publishers.otherModules.sink(receiveValue: { [weak self] others in
            self?.didLoad(latestRelease: others.0, collaborators: others.1, branches: others.2)
        })
        
        profileCancellable = publishers.profile.sink(receiveCompletion: { [weak self] result in
            switch result {
            case .failure:
                self?.status.value = .error
            case .finished:
                self?.status.value = .browsable
            }
            self?.profileCancellable = nil
        }, receiveValue: { [weak self] profile in
            self?.didLoad(profile: profile)
        })
    }
}

extension DetailViewModel {
    func didLoad(latestRelease: Release?, collaborators: [Collaborator], branches: [Branch]) {
        var filterd = contents.value.filter { !($0 is LoadingDisplayData) }
        
        if let first = branches.first {
            filterd.append(BranchDisplayData(with: first))
        }
        
        if let release = latestRelease {
            filterd.append(ReleaseDisplayData(with: release, status: ReleaseStatus(isDraft: release.isDraft, isPrerelease: release.isPreRelease)))
        }
        if !collaborators.isEmpty {
            filterd.append(DetailContributorTitleDisplayData())
            let filterdCollaborators = collaborators.prefix(displayCollaboratorsCount)
            filterd.append(CollaboratorsDisplayData(with: Array(filterdCollaborators)))
        }
        
        contents.value = filterd
    }
    
    func didLoad(profile: CommunityProfile) {
        let display = CommunityProfileDisplayData(with: profile)
        contents.value.insert(display, at: contents.value.startIndex)
        if self.otherModulesCancellable != nil {
            contents.value.append(LoadingDisplayData(nextLink: nil))
        }
        status.value = .browsable
    }
}
