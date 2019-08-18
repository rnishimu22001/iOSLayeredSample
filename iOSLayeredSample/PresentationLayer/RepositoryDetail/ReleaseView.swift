//
//  ReleaseView.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/08/18.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import UIKit

final class ReleaseView: UIView {
    @IBOutlet weak var tagName: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var status: UILabel!
    
    func setup(_ release: ReleaseDisplayable) {
        tagName.text = release.tagName
        date.text = release.publishedDate
        descriptionLabel.text = release.releaseDesciption
        status.text = release.status.rawValue
        status.backgroundColor = release.status.color
    }
}
