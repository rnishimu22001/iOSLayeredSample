//
//  CommunityProfileView.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/08/18.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import UIKit

final class CommunityProfileView: UIView, ContentViewInVerticalStack {
    var height: CGFloat {
        return 0
    }
    
    @IBOutlet var contents: UIView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var lastUpdateDate: UILabel!
    @IBOutlet weak var license: UILabel!
    @IBOutlet weak var communityDescription: UILabel!
    
    func setup(_ profile: CommunityProfileDisplayable) {
        Bundle.main.loadNibNamed(type(of: self).className, owner: self, options: nil)
        contents.frame = frame
        addSubview(contents)
        
        communityDescription.text = profile.repositoryDescription
        name.text = profile.name
        lastUpdateDate.text = profile.lastUpdate
        license.text = profile.license
    }
}
