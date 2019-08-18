//
//  RepositoryDetailPresenter.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/08/17.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import UIKit

protocol RepositoryDetailPresenterProtocol {
    init(with superView: UIView)
    func update(contents: [Displayable])
}

final class RepositoryDetailPresenter: NSObject, RepositoryDetailPresenterProtocol {
    @IBOutlet var contentsView: UIStackView!
    
    init(with superView: UIView) {
        superView.addSubview(contentsView)
        contentsView.frame = superView.frame
        let loadingView = LoadingView(frame: contentsView.frame)
        contentsView.addArrangedSubview(loadingView)
    }
    
    func update(contents: [Displayable]) {
        contentsView.subviews.filter({ $0 is LoadingView }).forEach { $0.removeFromSuperview() }
        contents.forEach {
            setupContentView(content: $0)
        }
    }
    
    private func setupContentView(content: Displayable) {
        switch content {
        case is LoadingDisplayable:
            let size = CGSize(width: self.contentsView.frame.size.width, height: LoadingView.height)
            let frame = CGRect(origin: .zero, size: size)
            let loading = LoadingView(frame: frame)
            contentsView.addArrangedSubview(loading)
        case let profile as CommunityProfileDisplayable:
            addContentView(for: profile)
        case let release as ReleaseDisplayable:
            addContentView(for: release)
        case let collaborators as CollaboratorsDisplayable:
            addContentView(for: collaborators)
        default:
            assert(true, "予期していないデータ型です")
        }
    }
    
    private func addContentView(for profile: CommunityProfileDisplayable) {
        var profileView: CommunityProfileView
        // if already exist profileview
        if let currentView = contentsView.subviews.filter({ $0 is CommunityProfileView }).first as? CommunityProfileView {
            profileView = currentView
        } else {
            let size = CGSize(width: contentsView.frame.size.width, height: 200)
            let frame = CGRect(origin: .zero, size: size)
            profileView = CommunityProfileView(frame: frame)
            profileView.setup(profile)
        }
        contentsView.addArrangedSubview(profileView)
    }
    
    private func addContentView(for release: ReleaseDisplayable) {
        var releaseView: ReleaseView
        if let currentView = contentsView.subviews.filter({ $0 is ReleaseView }).first as? ReleaseView {
            releaseView = currentView
        } else {
            let size = CGSize(width: contentsView.frame.size.width, height: 150)
            let frame = CGRect(origin: .zero, size: size)
            releaseView = ReleaseView(frame: frame)
            releaseView.setup(release)
        }
        contentsView.addArrangedSubview(releaseView)
    }
    
    private func addContentView(for collaborators: CollaboratorsDisplayable) {
        collaborators.collaborators.forEach {
            let size = CGSize(width: contentsView.frame.size.width, height: 100)
            let frame = CGRect(origin: .zero, size: size)
            let collaboratorView = CollaboratorView(frame: frame)
            collaboratorView.setup($0)
            contentsView.addArrangedSubview(collaboratorView)
        }
    }
}
