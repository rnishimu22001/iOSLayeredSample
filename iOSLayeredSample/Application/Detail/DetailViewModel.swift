//
//  DetailViewModel.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/08/18.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import Combine

protocol DetailViewModelInterface {
    var status: CurrentValueSubject<ContentsStatus, Never> { get }
    var contents: CurrentValueSubject<[Any], Never> { get }
    var repositoryFullName: String { get }
    func reload()
}

final class DetailViewModel: DetailViewModelInterface {
    let status: CurrentValueSubject<ContentsStatus, Never> = .init(.initalized)
    let contents: CurrentValueSubject<[Any], Never> = .init([])
    private(set) var useCase: DetailUseCaseInterface
    
    let repositoryFullName: String
    
    init(repositoryFullName: String,
         useCase: DetailUseCaseInterface = DetailUseCase()) {
        self.repositoryFullName = repositoryFullName
        self.useCase = useCase
        self.useCase.delegate = self
    }
    
    func reload() {
        status.value = .loading
        useCase.reload(repository: repositoryFullName)
    }
    
    private func update() {
        self.contentsUpdate()
        self.updateStatus()
    }
    
    /// コンテンツのステータスの更新状態を見て通知が必要か、どのデータを更新させるかを決める
    func contentsUpdate() {
        var contents: [Any] = []
        if let profile = useCase.profile {
            contents.append(CommunityProfileDisplayData(with: profile))
        }
        if let release = useCase.latestRelease {
            let status = ReleaseStatus(isDraft: release.draft, isPrerelease: release.prerelease)
            contents.append(ReleaseDisplayData(with: release, status: status))
        }
        if !useCase.collaborators.isEmpty {
            let collaboratorList = useCase.collaborators.map { CollaboratorDisplayData(with: $0) }
            contents.append(CollaboratorsDisplayData(collaborators: collaboratorList))
        }
        if useCase.shouldShowLoadingFooter {
            contents.append(LoadingDisplayData())
        }
        guard !contents.isEmpty else { return }
        self.contents.value = contents
    }
    
    func updateStatus() {
        var status: ContentsStatus
        defer {
            // 同値の場合は更新なし
            if self.status.value != status {
                self.status.value = status
            }
        }
        guard !self.useCase.isLoading else {
            status = .loading
            return
        }
        guard !self.useCase.isError else {
            status = .error
            return
        }
        status = .browsable
    }
}

extension DetailViewModel: DetailUseCaseDelegate {
    func detailUseCase(_ useCase: DetailUseCaseInterface, didLoad latestRelease: Release?, collaborators: [Collaborator]) {
        self.update()
    }
    
    func detailUseCase(_ useCase: DetailUseCaseInterface, didLoad profile: CommunityProfile?) {
        
        self.update()
    }
}
