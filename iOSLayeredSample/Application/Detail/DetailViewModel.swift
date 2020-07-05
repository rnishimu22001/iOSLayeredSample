//
//  DetailViewModel.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/08/18.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import Foundation
import Combine

protocol DetailViewModelProtocol {
    /// 表示状態
    var status: ContentsStatus { get }
    /// 表示するコンテンツ
    var contents: [Any] { get }
    /// 表示のリロード
    func reload()
}

final class DetailViewModel: ObservableObject, DetailViewModelProtocol {
    @Published var status: ContentsStatus = .initalized
    @Published var contents: [Any] = []
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
        var filterd = contents.filter { !($0 is LoadingDisplayData) }
        
        if let first = branches.first {
            filterd.append(BranchDisplayData(with: first))
        }
        
        if let release = latestRelease {
            filterd.append(ReleaseDisplayData(with: release, status: ReleaseStatus(isDraft: release.isDraft, isPrerelease: release.isPreRelease)))
        }
        if !collaborators.isEmpty {
            filterd.append(DetailContributorTitleDisplayData())
            filterd.append(CollaboratorsDisplayData(with: collaborators))
        }
        otherModulesCancellable = nil
        DispatchQueue.asyncAtMain { [weak self] in
            self?.contents = filterd
        }
    }
    
    private func didLoad(profile: CommunityProfile) {
        let display = CommunityProfileDisplayData(with: profile)
        profileCancellable = nil
        DispatchQueue.asyncAtMain { [weak self] in
            guard let self = self else {
                return
            }
            self.contents.insert(display, at: self.contents.startIndex)
            if self.otherModulesCancellable != nil {
                self.contents.append(LoadingDisplayData(nextLink: nil))
            }
            self.status = .browsable
        }
    }
}
