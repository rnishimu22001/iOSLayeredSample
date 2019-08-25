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
    func update(status: ContentsStatus)
}

final class RepositoryDetailPresenter: NSObject, RepositoryDetailPresenterProtocol {
    
    @IBOutlet var view: UIView!
    @IBOutlet var contentsView: UIStackView!
    @IBOutlet weak var error: UIView!
    @IBOutlet weak var loading: LoadingView!
    
    init(with superView: UIView) {
        super.init()
        Bundle.main.loadNibNamed(type(of: self).className, owner: self, options: nil)
        superView.addSubview(view)
        view.frame = superView.frame
        // self.loading.indicator.startAnimating()
    }
    
    func update(status: ContentsStatus) {
        switch status {
        case .browsable:
            contentsView.isHidden = false
            error.isHidden = true
            loading.isHidden = true
        case .initalized, .loading:
            contentsView.isHidden = true
            error.isHidden = true
            loading.isHidden = false
        case .error:
            contentsView.isHidden = true
            error.isHidden = false
            loading.isHidden = true
        }
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
        case let collaborators as CollaboratorsDisplayData:
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
    
    private func addContentView(for collaborators: CollaboratorsDisplayData) {
        collaborators.collaborators.forEach {
            let size = CGSize(width: contentsView.frame.size.width, height: 100)
            let frame = CGRect(origin: .zero, size: size)
            let collaboratorView = CollaboratorView(frame: frame)
            collaboratorView.setup($0)
            contentsView.addArrangedSubview(collaboratorView)
        }
    }
}
