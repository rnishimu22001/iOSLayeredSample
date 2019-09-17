//
//  ReleaseView.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/08/18.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import UIKit

final class ReleaseView: UIView {
    
    static let height: CGFloat = 100
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var tagName: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var status: UILabel!
    
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
        addSubview(view)
        view.frame = self.frame
    }
    
    
    func setup(_ release: ReleaseDisplayData) {
        tagName.text = release.tagName
        date.text = release.publishedDate
        descriptionLabel.text = release.releaseDesciption
        status.text = release.status.rawValue
        status.backgroundColor = release.status.color
    }
}
