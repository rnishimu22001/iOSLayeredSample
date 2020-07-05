//
//  DetailViewModel.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/08/18.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import Foundation
import Combine

final class DetailViewModel: ObservableObject {
    
    @Published var status: ContentsStatus = .initalized
    
    // MARK: Contents Modules
    @Published var profile: CommunityProfileDisplayData?
    @Published var release: ReleaseDisplayData?
    @Published var branch: BranchDisplayData?
    @Published var collaborators: CollaboratorsDisplayData?
    @Published var pagingLoading: LoadingDisplayData?
    
    private var useCase: DetailUseCaseProtocol
    
    private var otherModulesCancellable: AnyCancellable?
    private var profileCancellable: AnyCancellable?
    private let repositoryFullName: String
    
    init(repositoryFullName: String,
         useCase: DetailUseCaseProtocol = DetailUseCase()) {
        self.repositoryFullName = repositoryFullName
        self.useCase = useCase
    }
    
    func reload() {
        status = .loading
        let publishers = useCase.reload(repository: repositoryFullName)
        otherModulesCancellable = publishers.otherModules.sink(receiveValue: { [weak self] others in
            self?.didLoad(latestRelease: others.0,
                          collaborators: others.1,
                          branches: others.2)
        })
        
        profileCancellable = publishers.profile.sink(receiveCompletion: { [weak self] result in
            self?.profileCancellable = nil
            DispatchQueue.asyncAtMain { [weak self] in
                guard let self = self else {
                    return
                }
                switch result {
                case .failure:
                    self.status = .error
                case .finished:
                    self.status = .browsable
                }
            }
        }, receiveValue: { [weak self] profile in
            self?.didLoad(profile: profile)
        })
    }
}

extension DetailViewModel {
    
    private func didLoad(latestRelease: Release?, collaborators: [Collaborator], branches: [Branch]) {
        otherModulesCancellable = nil
        DispatchQueue.asyncAtMain { [weak self] in
            guard let self = self else {
                return
            }
            self.pagingLoading = nil
            if let first = branches.first {
                self.branch = BranchDisplayData(with: first)
            }
            
            if let release = latestRelease {
                self.release = ReleaseDisplayData(with: release, status: ReleaseStatus(isDraft: release.isDraft, isPrerelease: release.isPreRelease))
            }
            if !collaborators.isEmpty {
                self.collaborators = CollaboratorsDisplayData(with: collaborators)
            }
        }
    }
    
    private func didLoad(profile: CommunityProfile) {
        let display = CommunityProfileDisplayData(with: profile)
        profileCancellable = nil
        DispatchQueue.asyncAtMain { [weak self] in
            guard let self = self else {
                return
            }
            self.profile = display
            if self.otherModulesCancellable != nil {
                self.pagingLoading = LoadingDisplayData(nextLink: nil)
            }
            self.status = .browsable
        }
    }
}
