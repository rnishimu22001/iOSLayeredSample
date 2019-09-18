//
//  DetailView.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/08/17.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import UIKit

protocol DetailViewProtocol {
    init(with superView: UIView)
    func update(contents: [Any])
    func update(status: ContentsStatus)
}

final class DetailPresenter: NSObject, DetailViewProtocol {
    
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
    
    func update(contents: [Any]) {
        // contentsView.subviews.filter({ $0 is LoadingView }).forEach { $0.removeFromSuperview() }
        contentsView.arrangedSubviews.forEach {
            self.contentsView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        contents.forEach {
            setupContentView(content: $0)
        }
    }
    
    private func setupContentView(content: Any) {
       
        switch content {
        case is LoadingDisplayData:
            let size = CGSize(width: self.contentsView.frame.size.width, height: LoadingView.height)
            let frame = CGRect(origin: .zero, size: size)
            let loading = LoadingView(frame: frame)
            contentsView.addArrangedSubview(loading)
        case let profile as CommunityProfileDisplayData:
            addContentView(for: profile)
        case let release as ReleaseDisplayData:
            addContentView(for: release)
        case let collaborators as CollaboratorsDisplayData:
            addContentView(for: collaborators)
        default:
            assert(true, "予期していないデータ型です")
        }
    }
    
    private func addContentView(for profile: CommunityProfileDisplayData) {
        var profileView: CommunityProfileView
        
        let size = CGSize(width: contentsView.frame.size.width, height: CommunityProfileView.height)
        let frame = CGRect(origin: .zero, size: size)
        profileView = CommunityProfileView(frame: frame)
        profileView.setup(profile)
        profileView.heightAnchor.constraint(equalToConstant: CommunityProfileView.height).isActive = true
        
        contentsView.addArrangedSubview(profileView)
    }
    
    private func addContentView(for release: ReleaseDisplayData) {
        var releaseView: ReleaseView

        let size = CGSize(width: contentsView.frame.size.width, height: ReleaseView.height)
        let frame = CGRect(origin: .zero, size: size)
        releaseView = ReleaseView(frame: frame)
        releaseView.setup(release)
        releaseView.heightAnchor.constraint(equalToConstant: ReleaseView.height).isActive = true

        contentsView.addArrangedSubview(releaseView)
    }
    
    private func addContentView(for collaborators: CollaboratorsDisplayData) {
        collaborators.collaborators.forEach {
            let size = CGSize(width: contentsView.frame.size.width, height: CollaboratorView.height)
            let frame = CGRect(origin: .zero, size: size)
            let collaboratorView = CollaboratorView(frame: frame)
            collaboratorView.setup($0)
            collaboratorView.heightAnchor.constraint(equalToConstant: CollaboratorView.height).isActive = true
            contentsView.addArrangedSubview(collaboratorView)
        }
    }
}
