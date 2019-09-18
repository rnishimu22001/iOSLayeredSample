//
//  CommunityProfileView.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/08/18.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import UIKit

final class CommunityProfileView: UIView {
    
    static let height: CGFloat = 100
    
    @IBOutlet var contents: UIView!
    @IBOutlet weak var lastUpdateDate: UILabel!
    @IBOutlet weak var license: UILabel!
    @IBOutlet weak var communityDescription: UITextView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
    Bundle.main.loadNibNamed(type(of: self).className, owner: self, options: nil)
        addSubview(contents)
        contents.frame = self.frame
    }
    
    func setup(_ profile: CommunityProfileDisplayData) {
        communityDescription.text = profile.repositoryDescription
        lastUpdateDate.text = profile.lastUpdate
        license.text = profile.license
    }
}
