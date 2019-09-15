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
    private(set) var isLoadingOtherModule: Bool = false
     
    let repositoryFullName: String
    
    init(repositoryFullName: String,
         useCase: DetailUseCaseProtocol = DetailUseCase()) {
        self.repositoryFullName = repositoryFullName
        self.useCase = useCase
        self.useCase.delegate = self
    }
    
    func reload() {
        status.value = .loading
        useCase.reload(repository: repositoryFullName)
    }
}

extension DetailViewModel: DetailUseCaseDelegate {
    func detailUseCase(_ useCase: DetailUseCaseProtocol, didLoad latestRelease: Release?, collaborators: [Collaborator]) {
        var filterd = contents.value.filter { !($0 is LoadingDisplayData) }
        if let release = latestRelease {
            filterd.append(ReleaseDisplayData(with: release, status: ReleaseStatus(isDraft: release.isDraft, isPrerelease: release.isPreRelease)))
        }
        if !collaborators.isEmpty {
            filterd.append(CollaboratorsDisplayData(with: collaborators))
        }
        contents.value = filterd
    }
    
    func detailUseCase(_ useCase: DetailUseCaseProtocol, didLoad profile: CommunityProfile?) {
        guard let communityProfile = profile else {
            status.value = .error
            return
        }
        let display = CommunityProfileDisplayData(with: communityProfile)
        contents.value.insert(display, at: contents.value.startIndex)
        if isLoadingOtherModule {
            contents.value.append(LoadingDisplayData(nextLink: nil))
        }
        status.value = .browsable
    }
}
